//
//  Resource.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

struct Resource<T: Codable> {
    var url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
    var modelType: T.Type
}
