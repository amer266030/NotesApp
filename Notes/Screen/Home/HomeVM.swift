//
//  HomeVm.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Observation

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
        
    }
    
}
