//
//  MoviesRouter.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

@objc protocol MoviesRoutingLogic {
    func routeToMovieDetails(segue: UIStoryboardSegue)

    func navigateToMovieDetails()
}

protocol MoviesDataPassing {

    var dataStore: MoviesDataStore? { get }
}

class MoviesRouter: NSObject {

    weak var viewController: MoviesViewController?
    public var dataStore: MoviesDataStore?
}

// MARK: - Movies Routing Logic
extension MoviesRouter: MoviesRoutingLogic {

    func routeToMovieDetails(segue: UIStoryboardSegue) {
        let movieDetailsViewController = segue.destination as? MovieDetailsViewController
        movieDetailsViewController?.delegate = viewController
        var movieDetailsDataStore = movieDetailsViewController?.router?.dataStore
        movieDetailsDataStore?.movie = dataStore?.movie
    }

    func navigateToMovieDetails() {
        viewController?.performSegue(withIdentifier: R.segue.moviesViewController.movieDetails.identifier, sender: .none)
    }
}

// MARK: - Movies Data Passing
extension MoviesRouter: MoviesDataPassing {
}
