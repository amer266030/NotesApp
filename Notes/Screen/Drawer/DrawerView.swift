//
//  DrawerView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct DrawerView: View {
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                ContainerRelativeShape()
                    .fill(.background.gradient)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 24) {
                    avatarView()
                    
                    Divider()
                        .frame(minHeight: 1)
                        .background(.white)
                    
                    AnimatedButton {
                        
                    } label: {
                        linkItem(img: "person", title: "Profile")
                    }
                    
                    NavigationLink {
                        AddNoteView()
                            .navigationTitle("Add Note")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        linkItem(img: "note.text.badge.plus", title: "New Note")
                    }
                    
                    AnimatedButton {
                        
                    } label: {
                        linkItem(img: "gear", title: "Settings")
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.width/2)
            Spacer()
        }
        
    }
}

fileprivate func avatarView() -> some View {
    VStack(spacing: 16) {
        Image(systemName: "person")
            .resizable()
            .foregroundStyle(Color.black.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .aspectRatio(contentMode: .fit)
            .padding(32)
            .background(.gray.gradient.opacity(0.1), in: Circle())
            .background(
                Circle()
                    .fill(Color.white.opacity(0.5)
                        .shadow(.drop(radius: 4, x: 0, y: 4))
                    )
            )
            .padding(.horizontal, 32)
        
        Text("John Doe")
            .foregroundStyle(.black)
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    
}

fileprivate func linkItem(img: String, title: String) -> some View {
    HStack {
        Image(systemName: img)
            .symbolEffect(.wiggle, options: .repeat(.periodic(delay: 5)))
            .frame(minWidth: 25, minHeight: 25)
            .foregroundStyle(Color.background)
            .padding(4)
            .background(.blue.gradient, in: .rect(cornerRadius: 8))
        
        Text(title)
            .foregroundStyle(.text)
            .contentTransition(.numericText())
    }
    .font(.headline)
}


#Preview {
    NavigationStack {
        DrawerView()
    }
}
