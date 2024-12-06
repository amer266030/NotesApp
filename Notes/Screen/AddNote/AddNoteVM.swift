//
//  AddNoteVM.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

@Observable
class AddNoteVM {
    private let httpClient = HTTPClient()
    var serverTime: ServerTime?
    var title: String = ""
    var body: String = ""
    
    func fetchTime() async throws {
        print("Fetching Started!")
        do {
            guard let url = URL(string: TimeAPI.baseURL) else { return }
            let resource = Resource(url: url, modelType: ServerTime.self)
            serverTime = try await httpClient.load(resource)
            print("Fetching Completed!")
        } catch let error{
            print("Error: \(error.localizedDescription)")
        }
        
    }
}
