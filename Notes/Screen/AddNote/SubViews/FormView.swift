//
//  FormView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct FormView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var vm: AddNoteVM
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                Picker("", selection: $vm.note.category) {
                    ForEach(NoteCategory.allCases) { cat in
                        Text(cat.rawValue)
                            .tag(cat)
                    }
                }
                .pickerStyle(.segmented)
                
                Text("Title")
                TextField("Shopping", text: $vm.note.title)
                    .padding()
                    .background(.thinMaterial, in: .rect(cornerRadius: 8))
                Text("Note")
                TextField("Buy Apples", text: $vm.note.body, axis: .vertical)
                    .lineLimit(6, reservesSpace: true)
                    .padding()
                    .background(.thinMaterial, in: .rect(cornerRadius: 8))
                HStack {
                    Text("Created At:")
                    Spacer()
                    Text(vm.note.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                }
                HStack {
                    Text("Updated At:")
                    Spacer()
                    Text(vm.note.updatedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                }
                Button {
                    Task {
                        let isNoteSaved = await vm.saveNote()
                        print(isNoteSaved)
                        if isNoteSaved { dismiss() }
                    }
                } label: {
                    Text(vm.isUpdate ? "Update" : "Create")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue, in: .rect(cornerRadius: 16))
                }
                .padding(.vertical, 24)
            }
        }
        .scrollIndicators(.hidden)
        .padding()
    }
}
