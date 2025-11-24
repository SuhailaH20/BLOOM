//
//  ContentView.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 03/06/1447 AH.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        ZStack {
            backgroundImage()
            
            VStack(alignment: .center){
                Image("rainbow")
                    .resizable()
                    .frame(width: 1150, height: 87.23)
                Spacer().frame(height: 160)
                
                
                Image("logo")
                    .resizable()
                    .frame(width: 559, height: 197)
                Spacer().frame(height: 20)
   

        
                Image("welcome")
                    .resizable()
                    .frame(width: 339, height: 312)
                Spacer().frame(height: 90)

                
                Button(action: {
                    // Your action here
                }) {
                    Text("Get Started")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

            }

        }
        
    }
}

struct backgroundImage: View {
    var body: some View {
        Image("background")
            .resizable()
            .ignoresSafeArea()
            .frame(width: 850, height: 1180)
    }
}

#Preview {
    WelcomePage()
}
