//
//  MovieDetailsModels.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 03.12.2020.
//  Copyright (c) 2020 Data Kondzhariia. All rights reserved.
//

import UIKit

enum MovieDetails {

    struct DisplayedMovie {
        let name: String
        let summary: String
        let avatarUrl: String
    }

    enum SetupInfo {
        struct Request {
        }

        struct Response {
            let movie: Movie
        }

        struct ViewModel {
            let displayedMovie: DisplayedMovie
        }
    }

    enum UpdateInfo {
        struct Request {
        }

        struct Response {
            let movie: Movie
            let error: Error?
        }

        struct ViewModel {
            let displayedMovie: DisplayedMovie
            let error: Error?
        }
    }
}
