//
//  MoviesModels.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import UIKit

enum Movies {
    
    enum Load {
        struct Request {
        }

        struct Response {
            let movies: [Movie]
            let error: Error?
        }

        struct ViewModel {
            struct DisplayedMovie {
                let summary: String
                let avatarUrl: String
            }

            let displayedMovies: [DisplayedMovie]
        }
    }

    enum Select {
        struct Request {
            let index: Int
        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum ClearAnimationIds {
        struct Request {
        }

        struct Response {
            let index: Int?
        }

        struct ViewModel {
            let index: Int?
        }
    }
}
