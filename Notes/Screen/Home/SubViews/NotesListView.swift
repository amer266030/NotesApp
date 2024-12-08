//
//  NotesListView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct NotesListView: View {
    @ObservedObject var vm: HomeVM
    
    var body : some View {
        List {
            ForEach(vm.filteredNotes, id: \.0) { category, notes in
                Section(header: Text(category.rawValue)) {
                    ForEach(notes) { note in
                        NoteCellItem(category: category, note: note)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                NavigationLink {
                                    AddNoteView(note)
                                        .navigationTitle("Edit Note")
                                        .navigationBarTitleDisplayMode(.inline)
                                } label: {
                                    Text("Edit")
                                }
                                .tint(.blue)
                                
                                Button("Delete") {
                                    vm.delete(note)
                                }
                                .tint(.red)
                            }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}
