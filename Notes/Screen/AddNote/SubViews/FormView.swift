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
                
                HStack {
                    Text("Title")
                    Image(systemName: "staroflife.fill")
                        .foregroundStyle(Color.red)
                        .font(.caption2)
                }
                TextField("Shopping", text: $vm.note.title, onCommit: {
                    dismissKeyboard()
                })
                    .padding()
                    .foregroundStyle(Color.text)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                Color.background
                                    .shadow(.drop(color: .text.opacity(0.2), radius: 2, x: 2, y: 2))
                            )
                    }
                HStack {
                    Text("Note")
                    Image(systemName: "staroflife.fill")
                        .foregroundStyle(Color.red)
                        .font(.caption2)
                }
                TextField("Buy Apples", text: $vm.note.body, axis: .vertical)
                    .lineLimit(6, reservesSpace: true)
                    .padding()
                    .foregroundStyle(Color.text)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                Color.background
                                    .shadow(.drop(color: .text.opacity(0.2), radius: 2, x: 2, y: 2))
                            )
                    }
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
