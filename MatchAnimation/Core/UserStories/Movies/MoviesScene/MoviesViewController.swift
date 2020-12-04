//
//  MoviesViewController.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

protocol MoviesDisplayLogic: class {
    func displayLoadMoviesSuccess(viewModel: Movies.Load.ViewModel)
    func displayLoadMoviesError(viewModel: Movies.Load.ViewModel)

    func displaySelectMovieSuccess(viewModel: Movies.Select.ViewModel)

    func displayClearIdsSuccess(viewModel: Movies.ClearAnimationIds.ViewModel)
}

class MoviesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    public var interactor: MoviesBusinessLogic?
    public var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

    private var displayedMovies = [Movies.Load.ViewModel.DisplayedMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()

        MoviesConfigurator.shared.configure(self)

        setupUI()
        load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareRoute(for: segue, router: router)
    }
}

// MARK: - Private Methods
extension MoviesViewController {

    private func setupUI() {
        tableView.register(R.nib.moviesTableViewCell)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0.0, bottom: 0.0, right: 0.0)
    }

    private func load() {
        let request = Movies.Load.Request()
        interactor?.movies(request: request)
    }
}

// MARK: - Table View Data Source
extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.moviesTableViewCell, for: indexPath)!
        let movie = displayedMovies[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
}

// MARK: - Table View Delegate
extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! MoviesTableViewCell
        cell.setAnimationIDs()

        let request = Movies.Select.Request(index: indexPath.row)
        interactor?.selectMovie(request: request)
    }
}

// MARK: - Movie Details View Controller Delegate
extension MoviesViewController: MovieDetailsViewControllerDelegate {

    func movieDetailsDidFinish() {
        let request = Movies.ClearAnimationIds.Request()
        interactor?.clearIds(request: request)
    }
}

// MARK: - Movies Display Logic
extension MoviesViewController: MoviesDisplayLogic {
    
    func displayLoadMoviesSuccess(viewModel: Movies.Load.ViewModel) {
        displayedMovies = viewModel.displayedMovies
        tableView.reloadData()
    }

    func displayLoadMoviesError(viewModel: Movies.Load.ViewModel) {
    }

    func displaySelectMovieSuccess(viewModel: Movies.Select.ViewModel) {
        router?.navigateToMovieDetails()
    }

    func displayClearIdsSuccess(viewModel: Movies.ClearAnimationIds.ViewModel) {
        guard let index = viewModel.index else {
            return
        }

        let indexPath = IndexPath(row: index, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as? MoviesTableViewCell
        cell?.clearAnimationIDs()
    }
}
