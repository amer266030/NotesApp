//
//  NetworkError.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String?
}

enum NetworkError: Error {
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid Response"
        case .errorResponse(let errorResponse):
            return "Error Response: \(errorResponse.message ?? "")"
        }
    }
}
