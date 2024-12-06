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
                        .fill(.background.gradient)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Notes")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.text)
                        
                        if vm.notes.isEmpty {
                            ContentUnavailableView("No Notes", systemImage: "exclamationmark.triangle.fill", description: Text("You haven't added any notes yet!"))
                                .foregroundStyle(.text)
                        } else {
                            NotesListView(vm: vm)
                        }
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
            .onAppear { vm.fetchNotes() }
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

#Preview {
    HomeView()
}
