//
//  HomeVm.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Observation
import Foundation

@Observable
class HomeVM {
    var notes: [Note] = []
    var showDrawer = false
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        notes = MockData.shared.notes
    }
    
    func filterNotesByCategory(_ category: NoteCategory) -> [Note] {
        notes.filter({$0.category == category})
    }
    
    func delete(_ note: Note) {
        do {
            guard let idx = notes.firstIndex(of: note) else {
                throw NSError()
            }
            notes.remove(at: idx)
        } catch {
            print("Failed to delete note")
        }
    }
    
}
