//
//  HomeView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct HomeView: View {
    @Bindable var vm = HomeVM()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                ZStack(alignment: .topLeading) {
                    ContainerRelativeShape()
                        .fill(.white.gradient)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Your main content
                        List {
                            ForEach(NoteCategory.allCases) { cat in
                                Section(header: Text(cat.rawValue)) {
                                    ForEach(vm.filterNotesByCategory(cat)) { note in
                                        listItem(cat: cat, note: note)
                                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                                NavigationLink {
                                                    AddNoteView()
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
                    .padding(16)
                }
                .blur(radius: vm.showDrawer ? 4 : 0)
                
                if vm.showDrawer {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.5)) {
                                vm.showDrawer = false
                            }
                        }
                    DrawerView()
                        .transition(.move(edge: .leading))
                        .zIndex(2)
                }
            }
            .navigationTitle(vm.showDrawer ? "" : "Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !vm.showDrawer {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.smooth) {
                                vm.showDrawer = true
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.black)
                                .symbolEffect(.wiggle, options: .repeat(.periodic(delay: 2)))
                        }
                    }
                }
            }
        }
    }
}

fileprivate func listItem(cat: NoteCategory, note: Note) -> some View {
    HStack {
        Image(systemName: cat.img)
            .font(.body)
            .frame(minWidth: 25, minHeight: 25)
            .foregroundStyle(cat.color)
        
        Text(note.title ?? "")
        
        Spacer()
        
        Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
    }
    .font(.caption)
    .fontWidth(.condensed)
    .padding(8)
    .background {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                Color.white
                    .shadow(.drop(color: .black.opacity(0.2), radius: 2, x: 2, y: 2))
            )
    }
}


#Preview {
    HomeView()
}
