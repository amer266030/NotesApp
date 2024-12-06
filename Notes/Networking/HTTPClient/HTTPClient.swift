//
//  HTTPClient.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

struct HTTPClient {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .get(let queryItems):
            var componenets = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            componenets?.queryItems = queryItems
            guard let url = componenets?.url else {
                throw NetworkError.badRequest
            }
            request.url = url
        case .post(let data), .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .delete:
            request.httpMethod = resource.method.name
        }
   
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        default:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NetworkError.errorResponse(errorResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
