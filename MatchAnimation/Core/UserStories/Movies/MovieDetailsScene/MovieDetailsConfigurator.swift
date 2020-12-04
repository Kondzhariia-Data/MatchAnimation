//
//  MovieDetailsConfigurator.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

class MovieDetailsConfigurator {

    static let shared = MovieDetailsConfigurator()

    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Method
extension MovieDetailsConfigurator {

    public func configure(_ viewController: MovieDetailsViewController) {

        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
