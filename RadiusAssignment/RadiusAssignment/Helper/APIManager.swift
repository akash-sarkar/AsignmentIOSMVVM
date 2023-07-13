//
//  APIManager.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 29/06/23.
//

import Foundation

enum DataError: Error {
    case invalidUrl
    case invalidResponse
    case invalidDecoding
    case invalidData
    case message(_ error: Error?)
}

typealias handler = (Result<PropertyModel, DataError>) -> Void

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchProducts(completion: @escaping handler) {
        
        guard let url = URL(string: Constants.API.PropertyAPI) else { completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(.failure(.invalidData))
                return }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let property = try JSONDecoder().decode(PropertyModel.self, from: data)
                completion(.success(property))
            } catch {
                print(error)
                completion(.failure(.invalidDecoding))
            }
        }.resume()
        
    }
}
