//
//  HomeView.swift
//  Restart
//
//  Created by Petar Iliev on 6/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("isOnboarding") private var isOnboarding = true
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 15.0) {
            
            Spacer()
            
            // MARK: - HEADER
            ZStack {
                CircleGroupView(color: .gray, opacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        .easeInOut(duration: 4)
                        .repeatForever()
                        , value: isAnimating)
                    .padding()
            }
            
            // MARK: - CENTER
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.secondary)
                .font(.title3)
                .fontWeight(.light)
            
            Spacer()
            
            Button {
                isOnboarding = true
                playSound("success", "m4a")
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        } //: VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
