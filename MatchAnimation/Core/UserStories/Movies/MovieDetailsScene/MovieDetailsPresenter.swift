//
//  MovieDetailsPresenter.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

protocol MovieDetailsPresentationLogic {
    func presentSetupInfo(response: MovieDetails.SetupInfo.Response)
    func presentUpdateInfo(response: MovieDetails.UpdateInfo.Response)
}

class MovieDetailsPresenter {

    weak var viewController: MovieDetailsDisplayLogic?
}

extension MovieDetailsPresenter {
    private func setupDisplayedMovie(movie: Movie) -> MovieDetails.DisplayedMovie {
        return MovieDetails.DisplayedMovie(name: movie.name, summary: movie.summary, avatarUrl: movie.image.original)
    }
}

// MARK: - MovieDetails Presentation Logic
extension MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    func presentSetupInfo(response: MovieDetails.SetupInfo.Response) {
        let displayedMovie = setupDisplayedMovie(movie: response.movie)
        let viewModel = MovieDetails.SetupInfo.ViewModel(displayedMovie: displayedMovie)
        viewController?.displaySetupInfoSuccess(viewModel: viewModel)
    }

    func presentUpdateInfo(response: MovieDetails.UpdateInfo.Response) {
        let displayedMovie = setupDisplayedMovie(movie: response.movie)
        let viewModel = MovieDetails.UpdateInfo.ViewModel(displayedMovie: displayedMovie, error: response.error)

        if response.error != nil {
            viewController?.displayUpdateInfoError(viewModel: viewModel)
        } else {
            viewController?.displayUpdateInfoSuccess(viewModel: viewModel)
        }
    }
}
