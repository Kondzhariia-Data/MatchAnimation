//
//  MovieDetailsViewController.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: class {
    func displaySetupInfoSuccess(viewModel: MovieDetails.SetupInfo.ViewModel)

    func displayUpdateInfoSuccess(viewModel: MovieDetails.UpdateInfo.ViewModel)
    func displayUpdateInfoError(viewModel: MovieDetails.UpdateInfo.ViewModel)
}

protocol MovieDetailsViewControllerDelegate: class {
    func movieDetailsDidFinish()
}

class MovieDetailsViewController: UIViewController {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    private var displayedMovie: MovieDetails.DisplayedMovie!

    public var delegate: MovieDetailsViewControllerDelegate?

    public var interactor: MovieDetailsBusinessLogic?
    public var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?

    override func awakeFromNib() {
        super.awakeFromNib()

        MovieDetailsConfigurator.shared.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        delegate?.movieDetailsDidFinish()
    }
}

// MARK: - Private Methods
extension MovieDetailsViewController {
    // Requests
    private func setupInfo() {
        let request = MovieDetails.SetupInfo.Request()
        interactor?.setupInfo(request: request)
    }

    private func updateInfo() {
        let request = MovieDetails.UpdateInfo.Request()
        interactor?.updateInfo(request: request)
    }

    // Set Data
    private func setupMovieDetails() {
        nameLabel.text = displayedMovie.name
        summaryLabel.attributedText = displayedMovie.summary.htmlToAttributedString

        if let url = URL(string: displayedMovie.avatarUrl) {
            avatarImageView.load(url: url)
        } else {
            avatarImageView.image = R.image.placeholder()
        }
    }
}

// MARK: - Action
extension MovieDetailsViewController {

    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - MovieDetails Display Logic
extension MovieDetailsViewController: MovieDetailsDisplayLogic {

    func displaySetupInfoSuccess(viewModel: MovieDetails.SetupInfo.ViewModel) {
        displayedMovie = viewModel.displayedMovie
        setupMovieDetails()
        updateInfo()
    }

    func displayUpdateInfoSuccess(viewModel: MovieDetails.UpdateInfo.ViewModel) {
        displayedMovie = viewModel.displayedMovie
        setupMovieDetails()
    }

    func displayUpdateInfoError(viewModel: MovieDetails.UpdateInfo.ViewModel) {
    }
}
