//
//  NetworkService.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import Foundation

protocol Networking {
    func dataTask(with url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionNetworkService: Networking {
    func dataTask(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(data!))
                }
            }
            
        }.resume()
    }
}





