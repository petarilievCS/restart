//
//  OnboardingView.swift
//  Restart
//
//  Created by Petar Iliev on 6/13/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("isOnboarding") private var isOnboarding = true
    
    @State private var buttonWidth: CGFloat = UIScreen.main.bounds.width - 80.0
    @State private var buttonOffset: CGFloat = 0
    @State private var capsuleWidth: CGFloat = 80.0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var title: String = "Share"
    
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("BlueColor").ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                
                //MARK: - HEADER
                Spacer()
                VStack(spacing: 0) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                    Text("It's not how much we give but how much love we put into giving.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontWeight(.light)
                        .padding(.horizontal, 10)
                } //: VSTACK
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - CENTER
                ZStack {
                    
                    CircleGroupView(color: .white, opacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width) / 20))
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0.0
                                            title = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        title = "Share."
                                    }
                                })
                        ) //: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } //: CENTER
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .foregroundColor(.white)
                        .opacity(indicatorOpacity)
                }
                
                //MARK: - FOOTER
                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .offset(x:20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("RedColor"))
                            .frame(width: capsuleWidth)
                        Spacer()
                    } //: HSTACK
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("RedColor"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        } //: ZSTACK
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    let offset = value.translation.width
                                    if offset > 0 && offset < buttonWidth - 80 {
                                        buttonOffset = offset
                                        capsuleWidth = offset + 80.0
                                    }
                                })
                                .onEnded({ value in
                                    if value.translation.width > (buttonWidth / 2) {
                                        buttonOffset = buttonWidth - 80.0
                                        isOnboarding = false
                                        playSound("chimeup", "mp3")
                                        notificationFeedbackGenerator.notificationOccurred(.success)
                                    } else {
                                        buttonOffset = 0
                                        notificationFeedbackGenerator.notificationOccurred(.warning)
                                        capsuleWidth = 80.0
                                    }
                                })
                        ) //: GESTURE
                        Spacer()
                    } //: HSTACK
                    .onTapGesture {
                        isOnboarding = false
                    }
                } //: ZSTACK
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .offset(y: isAnimating ? 0 : 40)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut, value: isAnimating)
                
            } //: VSTACK
        } //: ZSTACK
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    } //: VIEW
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
