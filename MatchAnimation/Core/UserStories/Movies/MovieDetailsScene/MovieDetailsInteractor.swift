//
//  MovieDetailsInteractor.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

protocol MovieDetailsBusinessLogic {
    func setupInfo(request: MovieDetails.SetupInfo.Request)
    func updateInfo(request: MovieDetails.UpdateInfo.Request)
}

protocol MovieDetailsDataStore {
    var movie: Movie! { get set }
}

class MovieDetailsInteractor {

    public var presenter: MovieDetailsPresentationLogic?
    public var worker: MovieDetailsWorker

    var movie: Movie!

    init(worker: MovieDetailsWorker = MovieDetailsWorker()) {
        self.worker = worker
    }
}

// MARK: - MovieDetails Business Logic
extension MovieDetailsInteractor: MovieDetailsBusinessLogic {

    func setupInfo(request: MovieDetails.SetupInfo.Request) {
        let response = MovieDetails.SetupInfo.Response(movie: movie)
        presenter?.presentSetupInfo(response: response)
    }

    func updateInfo(request: MovieDetails.UpdateInfo.Request) {
        let currentMovie: Movie = movie

        worker.getMovie(id: movie.id, responseSeccess: { [weak self] movie in
            self?.movie = movie

            let response = MovieDetails.UpdateInfo.Response(movie: movie, error: nil)
            self?.presenter?.presentUpdateInfo(response: response)
        }, responseError: { [weak self] error in

            let response = MovieDetails.UpdateInfo.Response(movie: currentMovie, error: error)
            self?.presenter?.presentUpdateInfo(response: response)
        })
    }
}

// MARK: - MovieDetails Data Store
extension MovieDetailsInteractor: MovieDetailsDataStore {
}
