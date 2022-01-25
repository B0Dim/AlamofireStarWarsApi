//
//  NetworkManager.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(.success(value))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}
