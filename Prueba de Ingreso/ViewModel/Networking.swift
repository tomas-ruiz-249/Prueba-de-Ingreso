//
//  Networking.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 6/07/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case notInternetConnection
    case serverError
    case unknown
}

class Networking {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    static let urlUser = "/users"
    static let urlAllPosts = "/posts"
    static var urlSpecificPost = "/posts?userId=\(TableViewCell.userId!)"
    
    
    func request<T: Decodable>(path: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            completion(.failure(NetworkError.unknown))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(error ?? NetworkError.unknown))
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
             }
        }.resume()
    }
}
