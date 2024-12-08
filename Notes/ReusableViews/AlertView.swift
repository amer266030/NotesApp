//
//  AlertView.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import SwiftUI

struct AlertView: View {
    var popupMgr = PopupMgr.shared
    
    var body: some View {
        VStack(spacing: 16) {
            Text(popupMgr.alertTitle)
                .font(.title)
                .fontWeight(.semibold)
            Text(popupMgr.alertMsg)
                .font(.caption)
                .fontWeight(.light)
                .lineLimit(6)
            Button("Dismiss") {
                withAnimation(.easeOut(duration: 0.3)) {
                    popupMgr.dismissAlert()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 40)
        .background(Color.background.gradient, in: .rect(cornerRadius: 24))
        .padding(32)
    }
}

#Preview {
    AlertView()
}
