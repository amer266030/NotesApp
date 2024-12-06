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
    var note = Note(title: "", body: "", category: NoteCategory.Other)
    var isUpdate = false
    var isLoading = false
    var serverTime: ServerTime?
    
    init(_ note: Note?) {
        if let note {
            self.note = note
            isUpdate = true
        }
    }
    
    func fetchTime() async throws -> Date? {
        guard let url = URL(string: TimeAPI.baseURL) else { return nil }
        let resource = Resource(url: url, modelType: ServerTime.self)
        let serverTime = try await httpClient.load(resource)
        print(serverTime.datetime ?? "none!")
        let newFormatter = ISO8601DateFormatter()
        newFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = newFormatter.date(from: serverTime.datetime ?? "") else {
            print("Failed to parse date string: \(serverTime.datetime ?? "none!")")
            return nil
        }
        return date
    }
    
    func saveNote() async -> Bool {
        isLoading = true
        do {
            guard let date = try await fetchTime() else { throw NetworkError.invalidResponse }
            note.updatedAt = date
            if isUpdate {
                // UPDATE
                    if let idx = MockData.shared.notes.firstIndex(where: { $0.id == note.id }) {
                    MockData.shared.notes[idx] = note
                }
            } else {
                // CREATE
                note.createdAt = date
                MockData.shared.notes.append(note)
            }
            isLoading = false
            return true
        } catch let error {
            isLoading = false
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
    
}
