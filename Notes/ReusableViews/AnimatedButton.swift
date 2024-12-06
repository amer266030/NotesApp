//
//  AnimatedButton.swift
//  Notes
//
//  Created by Amer Alyusuf on 06/12/2024.
//

import SwiftUI

struct AnimatedButton<Content: View>: View {
    @State private var isTapped = false
    
    let action: () -> Void
    let label: () -> Content
    
    var body: some View {
        Button(action: {
            isTapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isTapped = false
                action()
            }
        }) {
            label()
                .scaleEffect(isTapped ? 0.8 : 1.0)
                .animation(.bouncy(duration: 0.5, extraBounce: 0.2), value: isTapped)
        }
    }
}


