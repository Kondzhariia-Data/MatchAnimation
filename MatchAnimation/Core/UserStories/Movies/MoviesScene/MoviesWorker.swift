//
//  MoviesWorker.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

class MoviesWorker {
    private var networkService: NetworkService<RequestBuilder>

    typealias ResponseSuccess = ([Movie]) -> Void
    typealias ResponseError = (Error) -> Void

    init(networkService: NetworkService<RequestBuilder> = NetworkService<RequestBuilder>()) {
        self.networkService = networkService
    }
}

// MARK: - Public Methods
extension MoviesWorker {

    public func getMovies(responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        networkService.request(service: .movies, decodeType: [Movie].self) { result in
            switch result {
            case.success(let movies):
                responseSuccess(movies)
            case .failure(let error):
                responseError(error)
            }
        }
    }
}
