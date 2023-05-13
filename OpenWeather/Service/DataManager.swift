//
//  DataManager.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation
struct DataManager {}

protocol Fetchable {
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ())
}

extension DataManager: Fetchable {
    func fetchData<T: Codable>(with request: APIRequest,
                               handler: @escaping (_ data: T?, _ error: NetworkError?) -> ()) {
        APIClient.send(request) { (result: Result<T, NetworkError>) in
            switch result {
            case .success(let data):
                handler(data, nil)
            case .failure(let failError):
                handler(nil, failError)
            }
        }
    }
}
