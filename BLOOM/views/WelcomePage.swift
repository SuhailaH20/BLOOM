//
//  ContentView.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 03/06/1447 AH.
//

import SwiftUI
import AVFoundation

struct WelcomePage: View {
    private var isArabic: Bool {
        Locale.current.language.languageCode?.identifier == "ar"
    }
    
    @State private var isActive: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .center) {

                Image(isArabic ? "logoAR" : "logo")
                    .resizable()
                    .frame(width: 650, height: 360)
                Spacer().frame(height: 20)
                
                Image("welcome")
                    .resizable()
                    .frame(width: 250, height: 260)
                Spacer().frame(height: 90)
                
                Button(action: {
                    isActive = true
                }) {
                    Text("Get Started")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 257, height: 92)
                        .background(Color.babyBlue)
                        .cornerRadius(10)
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:255/255,green:246/255,blue:236/255,opacity: 1.0))
            .ignoresSafeArea()
            
            
            .onAppear {
                configureAudioSession()
            }
            .navigationDestination(isPresented: $isActive) {
                LevelPage()
            }
            
        }
        
    }
    
}

private func configureAudioSession() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try AVAudioSession.sharedInstance().setActive(true)
    } catch {
        print("⚠️ Audio session setup error: \(error)")
    }
}

#Preview {
    WelcomePage()
}
