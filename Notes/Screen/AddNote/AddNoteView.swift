//
//  AddNoteView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct AddNoteView: View {
    @Bindable var vm = AddNoteVM()
    
    var body: some View {
        ZStack(alignment: .top) {
            ContainerRelativeShape()
                .fill(.background.gradient)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Server Time:")
                    Spacer()
                    Text(vm.serverTime?.datetime ?? "Loading...")
                }
                .font(.caption)
            }
            .fontWidth(.condensed)
            .foregroundStyle(.text)
            .padding()
        }
        .task {
            try? await vm.fetchTime()
        }
    }
}

#Preview {
    AddNoteView()
}
