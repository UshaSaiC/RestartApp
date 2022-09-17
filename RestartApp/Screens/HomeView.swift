//
//  HomeView.swift
//  RestartApp
//
//  Created by Usha Sai Chintha on 17/09/22.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var IsAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            // Header
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: IsAnimating ? 35 : -35)
                .animation(
                    Animation
                        .easeInOut(duration: 4)
                        .repeatForever()
                    , value: IsAnimating
                )
            }
            
            // Center
            Text("The time that needs to mastery depends on the intensity of focus")
                .fontWeight(.light)
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // Footer
            Spacer()
            
            
            Button(action: {
                withAnimation {
                    isOnboardingViewActive = true
                }

            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(perform: {
            // DispatchQueue manages exceution of tasks serially or concurrently on app's main or background thread
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                IsAnimating = true
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
