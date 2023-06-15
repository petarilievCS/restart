//
//  ContentView.swift
//  Restart
//
//  Created by Petar Iliev on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isOnboarding") private var isOnboarding = true
    
    var body: some View {
        ZStack {
            if isOnboarding {
                OnboardingView()
            } else {
                HomeView()
            }
        }
        .animation(.easeOut(duration: 0.4), value: isOnboarding)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
