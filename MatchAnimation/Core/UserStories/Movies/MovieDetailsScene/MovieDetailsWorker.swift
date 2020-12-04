//
//  MovieDetailsWorker.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

class MovieDetailsWorker {
    private var networkService: NetworkService<RequestBuilder>

    typealias ResponseSuccess = (Movie) -> Void
    typealias ResponseError = (Error) -> Void

    init(networkService: NetworkService<RequestBuilder> = NetworkService<RequestBuilder>()) {
        self.networkService = networkService
    }
}

// MARK: - Public Methods
extension MovieDetailsWorker {

    public func getMovie(id: Int, responseSeccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        networkService.request(service: .movie(id: id), decodeType: Movie.self) { result in
            switch result {
            case .success(let movie):
                responseSeccess(movie)
            case .failure(let error):
                responseError(error)
            }
        }
    }
}
