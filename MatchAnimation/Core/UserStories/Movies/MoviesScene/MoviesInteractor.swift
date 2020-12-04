//
//  MoviesInteractor.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

protocol MoviesBusinessLogic {
    func movies(request: Movies.Load.Request)
    func selectMovie(request: Movies.Select.Request)
    /// hero ids
    func clearIds(request: Movies.ClearAnimationIds.Request)
}

protocol MoviesDataStore {
    /// selected movie
    var movie: Movie! { get }
}

class MoviesInteractor {

    public var presenter: MoviesPresentationLogic?
    public var worker: MoviesWorker

    private var movies = [Movie]()

    var movie: Movie!

    init(worker: MoviesWorker = MoviesWorker()) {
        self.worker = worker
    }
}

// MARK: - Movies Business Logic
extension MoviesInteractor: MoviesBusinessLogic {

    func movies(request: Movies.Load.Request) {
        worker.getMovies(responseSuccess: { [weak self] movies in
            self?.movies = movies

            let response = Movies.Load.Response(movies: movies, error: nil)
            self?.presenter?.presentMovies(response: response)
        }, responseError: { [weak self] error in

            let response = Movies.Load.Response(movies: [], error: error)
            self?.presenter?.presentMovies(response: response)
        })
    }

    func selectMovie(request: Movies.Select.Request) {
        movie = movies[request.index]

        let response = Movies.Select.Response()
        presenter?.presentSelectMovie(response: response)
    }

    func clearIds(request: Movies.ClearAnimationIds.Request) {
        let index = movies.firstIndex(of: movie)
        let response = Movies.ClearAnimationIds.Response(index: index)
        presenter?.presentClearIds(response: response)
    }
}

// MARK: - Movies Data Store
extension MoviesInteractor: MoviesDataStore {
}
