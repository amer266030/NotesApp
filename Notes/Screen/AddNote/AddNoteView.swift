//
//  AddNoteView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct AddNoteView: View {
    @Bindable var vm: AddNoteVM
    var note: Note?
    
    init(_ note: Note? = nil) {
        vm = AddNoteVM(note)
    }
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.background.gradient)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                FormView(vm: vm)
            }
            .fontWidth(.condensed)
            .foregroundStyle(.text)
            .padding()
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }
}

#Preview {
    NavigationStack {
        AddNoteView()
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.large)
    }
}
