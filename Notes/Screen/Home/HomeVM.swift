//
//  HomeVm.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import Observation
import Foundation

//@Observable
class HomeVM: ObservableObject {
    private let dbMgr = DBMgr.shared
    private let popupMgr = PopupMgr.shared
    
    @Published var notes: [Note] = []
    @Published var showDrawer = false
    
    var filteredNotes: [(NoteCategory, [Note])] {
        Dictionary(grouping: notes, by: { $0.category })
            .map { ($0.key, $0.value) }
            .sorted { $0.0.sortPriority < $1.0.sortPriority }
    }
    
    init() { }
    
    func fetchNotes() {
        popupMgr.showLoading()
        do {
            notes = try dbMgr.notesTable.fetch()
            popupMgr.dismissLoading()
        } catch let error {
            popupMgr.showAlert(msg: "\(error)")
        }
    }
    
    func filterNotesByCategory(_ category: NoteCategory) -> [Note] {
        notes.filter({$0.category == category})
    }
    
    func delete(_ note: Note) {
        popupMgr.showLoading()
        do {
            guard let idx = notes.firstIndex(of: note) else {
                throw NSError()
            }
            try dbMgr.notesTable.delete(note)
            notes.remove(at: idx)
            popupMgr.dismissLoading()
        } catch let error {
            popupMgr.showAlert(msg: "\(error)")
        }
    }
    
}
