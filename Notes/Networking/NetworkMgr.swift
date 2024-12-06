//
//  NetworkMgr.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

class NetworkMgr {
    
    static let shared = NetworkMgr()
    
    private init() {}
    
    static let timeAPI = TimeAPI()
    static let sqlAPI = SqlAPI()
    
}



