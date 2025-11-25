//
//  Cards.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 04/06/1447 AH.
//

import SwiftUI

public struct Cards: View {
    public var body: some View {
        
        StepCard(color: .bluey) {
            StepCardContent(
                title: "Brushing Teeth",
                description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes.",
                imageName: "brushingTeeth1"
            )
        }


        .background(backgroundImage())
    }
}

struct StepCard<Content: View>: View {
    let color: Color
    let content: Content
    
    init(color: Color, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(width: 602, height: 782)
            .background(
                RoundedRectangle(cornerRadius: 69)
                    .foregroundStyle(color)
                    .shadow(color: Color.black.opacity(0.25), radius: 10, x: 9, y: 30)
                    .overlay(
                        Image("pattern")
                            .resizable()
                            .frame(width: 602, height: 782)
                            .cornerRadius(69)
                            .opacity(0.08)
                    )
            )
        
    }
}


struct StepCardContent: View {
    let title: String
    let description: String
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 20) {
                Text(title)
                    .font(.system(size: 72, weight: .bold))
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.system(size: 24, weight: .regular))
                    .multilineTextAlignment(.center)
                
                Image(imageName)
                    .resizable()
                    .frame(width: 343, height: 514)
                    .cornerRadius(16)
            }
            
  
            Button(action: {
                print("Play tapped")
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 91, height: 50)
                        .foregroundStyle(Color.red.opacity(0.8))
                    HStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(2)
        }
    }
}





#Preview {
    Cards()
}
