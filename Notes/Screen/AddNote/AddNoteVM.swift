//
//  AddNoteVM.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Foundation

@Observable
class AddNoteVM {
    private let popupMgr = PopupMgr.shared
    private let dbMgr = DBMgr.shared
    var note = Note(title: "", body: "", category: NoteCategory.Other)
    var isUpdate = false
    var serverTime: ServerTime?
    
    init(_ note: Note?) {
        if let note {
            self.note = note
            isUpdate = true
        }
    }
    
    func fetchTime() async throws -> Date? {
        let serverTime: ServerTime = try await NetworkManager.getRequest(urlString: NetworkManager.baseURL)
        guard let date = serverTime.datetime?.toDateFromISOString() else {
            print("Failed to parse date string: \(serverTime.datetime ?? "none!")")
            return nil
        }
        return date
    }
    
    func saveNote() async -> Bool {
        popupMgr.isLoading = true
        do {
            try validateNote()
            guard let date = try await fetchTime() else { throw NetworkError.invalidResponse }
            note.updatedAt = date
            if isUpdate {
                try dbMgr.notesTable.update(note)
            } else {
                note.createdAt = date
                try dbMgr.notesTable.insert(note)
            }
            popupMgr.isLoading = false
            return true
        } catch let error {
            popupMgr.showAlert(msg: "\(error.localizedDescription)")
            return false
        }
    }
    
    func validateNote() throws {
        if note.title.isEmpty {
            throw ValidationError.emptyField("Title")
        }
        if note.body.isEmpty {
            throw ValidationError.emptyField("Body")
        }
        print("Validation passed.")
    }
    
}
