//
//  Movie.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int
    let name: String
    let summary: String
    let image: MovieImage

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.summary == rhs.summary && lhs.image == rhs.image
    }
}
