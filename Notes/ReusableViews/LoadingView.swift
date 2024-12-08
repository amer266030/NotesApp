//
//  LoadingView.swift
//  Notes
//
//  Created by Amer Alyusuf on 08/12/2024.
//

import SwiftUI

struct LoadingView: View {
    @Binding var msg: String
    
    var body: some View {
        ProgressView(msg)
            .controlSize(.large)
            .padding(24)
            .background(.background.gradient, in: .rect(cornerRadius: 16))
    }
}

#Preview {
    LoadingView(msg: .constant("Loading"))
}
