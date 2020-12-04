//
//  MoviesPresenter.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

protocol MoviesPresentationLogic {
    func presentMovies(response: Movies.Load.Response)
    func presentSelectMovie(response: Movies.Select.Response)
    func presentClearIds(response: Movies.ClearAnimationIds.Response)
}

class MoviesPresenter {
    
    weak var viewController: MoviesDisplayLogic?
}

// MARK: - Private Method
extension MoviesPresenter {

    func setupDisplayedMovies(movies: [Movie]) -> [Movies.Load.ViewModel.DisplayedMovie] {
        var displayedMovies = [Movies.Load.ViewModel.DisplayedMovie]()

        movies.forEach { movie in
            let displayedMovie = Movies.Load.ViewModel.DisplayedMovie(summary: movie.summary, avatarUrl: movie.image.original)
            displayedMovies.append(displayedMovie)
        }

        return displayedMovies
    }
}

// MARK: - Movies Presentation Logic
extension MoviesPresenter: MoviesPresentationLogic {
    
    func presentMovies(response: Movies.Load.Response) {
        let displayedMovies = setupDisplayedMovies(movies: response.movies)
        let viewModel = Movies.Load.ViewModel(displayedMovies: displayedMovies)

        if response.error != nil {
            viewController?.displayLoadMoviesError(viewModel: viewModel)
        } else {
            viewController?.displayLoadMoviesSuccess(viewModel: viewModel)
        }
    }

    func presentSelectMovie(response: Movies.Select.Response) {
        let viewModel = Movies.Select.ViewModel()
        viewController?.displaySelectMovieSuccess(viewModel: viewModel)
    }

    func presentClearIds(response: Movies.ClearAnimationIds.Response) {
        let viewModel = Movies.ClearAnimationIds.ViewModel(index: response.index)
        viewController?.displayClearIdsSuccess(viewModel: viewModel)
    }
}
