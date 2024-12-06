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
    var filteredNotes: [(NoteCategory, [Note])] {
        Dictionary(grouping: notes, by: { $0.category })
            .map { ($0.key, $0.value) }
            .sorted { $0.0.sortPriority < $1.0.sortPriority }
    }
    var showDrawer = false
    
    init() { }
    
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
