//
//  MovieDetailsRouter.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

@objc protocol MovieDetailsRoutingLogic {
}

protocol MovieDetailsDataPassing {

    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: NSObject {

    weak var viewController: MovieDetailsViewController?
    public var dataStore: MovieDetailsDataStore?
}

// MARK: - MovieDetails Routing Logic
extension MovieDetailsRouter: MovieDetailsRoutingLogic {
}

// MARK: - MovieDetails Data Passing
extension MovieDetailsRouter: MovieDetailsDataPassing {
}
