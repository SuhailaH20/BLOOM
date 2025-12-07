//
//  ContentView.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 03/06/1447 AH.
//

import SwiftUI

struct BoardPage: View {
    @State private var selectedCard: String? = nil
    
    var body: some View {
        if selectedCard != nil {
            Cards(selectedCard: $selectedCard)
        } else {
            VStack {
                Image("Title")
                Spacer().frame(height: 42)
                
                AllCards(selectedCard: $selectedCard)
            }
           // .background(backgroundImage())
        }
    }
}

struct AllCards: View {
    @Binding var selectedCard: String?
    
    var body: some View {
        ScrollView{
            VStack(spacing: 42) {
                Button(action: {
                    selectedCard = "eatingFood"
                }) {
                    ColorCard(color: .babyBlue) {
                        CardContent(
                            imageName: "eating",
                            title: "Eating Food",
                            description: "Children should eat healthy food to  \n grow strong and stay active."
                        )
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "beingKind"
                }){
                    ColorCard(color: .babyYellow) {
                        CardContent(
                            imageName: "kind",
                            title: "Being kind",
                            description: "Children should be kind to others \n and treat them very well."
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "brushingHair"
                }){
                    ColorCard(color: .babyBlue) {
                        CardContent(
                            imageName: "combing",
                            title: "Combing hair",
                            description: "Children brush their hair and  take \ncare of their look."
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "brushingTeeth"
                }) {
                    ColorCard(color: .babyYellow) {
                        CardContent(
                            imageName: "brushingTeeth4",
                            title: "Brushing teeth",
                            description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes."
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                
                
            }
        }
    }
}

struct ColorCard<Content: View>: View {
    let color: Color
    let content: Content
    
    init(color: Color, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 42)
            .foregroundStyle(color)
            .shadow(color: Color.black.opacity(0.25), radius: 10, x: -8, y: 4)
            .overlay(
                content
                    .padding()
            )
            .frame(width: 598, height: 206)
    }
}

struct CardContent: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 155, height: 222)
            
            Spacer().frame(width: 44)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer().frame(height: 12)
                
                Text(description)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    BoardPage()
}
