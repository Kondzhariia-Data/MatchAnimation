//
//  MoviesConfigurator.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

class MoviesConfigurator {

    static let shared = MoviesConfigurator()

    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Method
extension MoviesConfigurator {

    public func configure(_ viewController: MoviesViewController) {

        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
