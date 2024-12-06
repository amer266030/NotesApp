//
//  HTTPMethod.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .delete:
            "DELETE"
        case .put:
            "PUT"
        }
    }
}
