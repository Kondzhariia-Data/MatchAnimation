//
//  RequestBuilder.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import Foundation
import Alamofire

protocol URLRequestBuilder {
    var baseURL: String { get }
    var url: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestBuilder {
    var baseURL: String {
        return "http://api.tvmaze.com/"
    }

    var url: String {
        return baseURL + path
    }
}

enum RequestBuilder: URLRequestBuilder {
    case movies
    case movie(id: Int)

    var path: String {
        switch self {
        case .movies:
            return "shows"
        case .movie(let id):
            return "shows/\(id)"
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: Parameters? {
        switch self {
        case .movies, .movie:
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .movies, .movie:
            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .movies:
            return URLEncoding.queryString
        case .movie:
            return URLEncoding.default
        }
    }
}
