//
//  NetworkService.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//

import Foundation
import Alamofire

enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}

class NetworkService<T: URLRequestBuilder> {

    func request<U: Codable>(service: T, decodeType: U.Type, completion: @escaping(Result<U>) -> Void) {
        AF.request(service.url, method: service.method, parameters: service.parameters, encoding: service.encoding).responseDecodable(of: U.self) {
             response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
