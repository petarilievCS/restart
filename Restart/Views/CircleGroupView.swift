//
//  CircleGroupView.swift
//  Restart
//
//  Created by Petar Iliev on 6/13/23.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State private var color: Color
    @State private var opacity: Double
    @State private var isAnimating: Bool = false

    init(color: Color, opacity: Double) {
        self.color = color
        self.opacity = opacity
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .stroke(color.opacity(opacity), lineWidth: 40)
                .frame(width: 260, height: 260)
            Circle()
                .stroke(color.opacity(opacity), lineWidth: 80)
                .frame(width: 260, height: 260)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 0.5), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            CircleGroupView(color: .white, opacity: 0.2)
        }
    }
}
