//
//  NetworkManager.swift
//  User
//
//  Created by Roopesh Tripathi on 23/04/24.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchData(from url: URL) -> AnyPublisher<Data,Error>
}

class NetworkManager: NetworkProtocol {
    
    func fetchData(from url: URL) -> AnyPublisher<Data,Error> {
        var data: Data?
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                switch response.statusCode {
                case 200...299: data = output.data
                default: throw URLError(.badURL)
                }
                return data ?? Data()
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
