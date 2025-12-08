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
            VStack{
                Spacer().frame(height: 42)
                Image("Title")
                Spacer().frame(height: 42)
                
                AllCards(selectedCard: $selectedCard)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:255/255,green:246/255,blue:236/255,opacity: 1.0))
            .ignoresSafeArea()
             
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
                            title:String(localized: "Eating food"),
                            description: String(localized:"Children should eat healthy food to grow strong and stay active.")
                        )
                    }
                    .padding(.horizontal, 70)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "beingKind"
                }){
                    ColorCard(color: .babyYellow) {
                        CardContent( 
                            imageName: "kind",
                            title: String(localized:"Being Kind"),
                            description:String(localized: "Children should be kind to others and treat them very well")
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "brushingHair"
                }){
                    ColorCard(color: .babyBlue) {
                        CardContent(
                            imageName: "combing",
                            title:String(localized:
                                "Combing hair"),
                            description:String(localized: "Children brush their hair and  take care of their look.")
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "brushingTeeth"
                }) {
                    ColorCard(color: .babyYellow) {
                        CardContent(
                            imageName: "Brush",
                            title: String(localized:"Brushing Teeth"),
                            description:String(localized: "Children brush their teeth twice a day with their beautiful toothbrushes.")
                        )
                    }
                }.buttonStyle(PlainButtonStyle())
                //-----------------
                Button(action: {
                    selectedCard = "Takingshower"
                }) {
                    ColorCard(color: .babyBlue) {
                        CardContent(
                            imageName: "Shower",
                            title: String(localized:"Taking Shower"),
                            description: String(localized:"When children get dirty they take shower in order to be clean.")
                        )}}.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "Screentime"
                }) {
                    ColorCard(color: .babyYellow) {
                        CardContent(
                            imageName: "Screen",
                            title: String(localized:"Screen Time"),
                            description: String(localized:"When we use screen for way too long our eyes and brains get tired.")
                        )}}.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "Washing"
                }) {
                    ColorCard(color: .babyBlue) {
                        CardContent(
                            imageName: "Washing",
                            title: String(localized:"Washing Hands"),
                            description: String(localized:"Children wash their hands before and after eating a meal.")
                        )}}.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedCard = "Sleep"
                }) {
                    ColorCard(color: .babyYellow) {
                        CardContent(
                            imageName: "Sleep",
                            title:String(localized: "Sleep Early"),
                            description: String(localized:"children need enough sleep time to grow strong and healthy .")
                        )}}.buttonStyle(PlainButtonStyle())
                
                
                
                
                
                
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
        HStack(spacing:0) {
            Image(imageName)
                .resizable()
                .frame(width: 155, height: 200)
            
            Spacer().frame(width: 44)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 50, weight: .bold))
                    .foregroundStyle(Color(red:55/255,green:55/255,blue:55/255,opacity: 1.0))
//
                Spacer().frame(height: 12)
                
                Text(description)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color(red:55/255,green:55/255,blue:55/255,opacity: 0.5))
                    
            }
        }
    }
}

#Preview {
    BoardPage()
}
