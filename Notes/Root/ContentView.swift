//
//  ContentView.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var connectionState: ConnectionState = .loading
    @Bindable var popupMgr = PopupMgr.shared
    
    var body: some View {
        Group {
            switch connectionState {
            case .connected:
                ZStack {
                    HomeView()
                        .allowsHitTesting(popupMgr.isPopupVisible ? false : true)
                        .overlay {
                            Color.black.opacity(popupMgr.isPopupVisible ? 0.5 : 0)
                        }
                        .blur(radius: popupMgr.isPopupVisible ? 4 : 0)
                    if popupMgr.isLoading {
                        ProgressView()
                            .controlSize(.large)
                            .padding()
                            .background(.regularMaterial, in: .rect(cornerRadius: 8))
                    } else if popupMgr.isAlertVisible {
                        AlertView()
                    }
                }
            case .failed:
                ContentUnavailableView("No Connection", systemImage: "exclamationmark.triangle.fill", description: Text("Connection to DB Failed"))
            case .loading:
                ProgressView()
            }
        }
        .task { await initializeApp() }
    }
    
    func initializeApp() async {
        do {
            try await DBMgr.shared.connectToDB()
            connectionState = .connected
        } catch {
            connectionState = .failed
        }
    }
}

#Preview {
    ContentView()
}
