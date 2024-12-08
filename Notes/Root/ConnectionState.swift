//
//  ConnectionState.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import Foundation

enum ConnectionState: Int, Identifiable, CaseIterable {
    case connected, failed, loading
    
    var id: Int { self.rawValue }
}
