//
//  NoteCellItem.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct NoteCellItem: View {
    var category: NoteCategory
    var note: Note
    
    var body: some View {
        HStack {
            Image(systemName: category.img)
                .font(.body)
                .frame(minWidth: 25, minHeight: 25)
                .foregroundStyle(category.color)
            
            Text(note.title)
                .foregroundStyle(.text)
            
            Spacer()
            
            Text(note.updatedAt.formatted(date: .abbreviated, time: .shortened))
                .foregroundStyle(.text)
        }
        .font(.caption)
        .fontWidth(.condensed)
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    Color.background
                        .shadow(.drop(color: .text.opacity(0.2), radius: 2, x: 2, y: 2))
                )
        }
    }
}
