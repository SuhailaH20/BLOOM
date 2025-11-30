//
//  Cards.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 04/06/1447 AH.
//

import SwiftUI

public struct Cards: View {
    @Binding var selectedCard: String?
    
    public var body: some View {
        if let selected = selectedCard, selected == "eatingFood" {
            EatingFoodCardsView(selectedCard: $selectedCard)
        } else {
            StepFlowView()
                .background(backgroundImage())
        }
    }
}


struct StepCard<Content: View>: View {
    let color: Color
    let content: Content
    let currentIndex: Int
    let totalSteps: Int
    
    init(
        color: Color,
        currentIndex: Int,
        totalSteps: Int,
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.currentIndex = currentIndex
        self.totalSteps = totalSteps
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 24) {

            // PROGRESS DOTS
            HStack(spacing: 12) {
                ForEach(0..<totalSteps, id: \.self) { index in
                    Circle()
                        .frame(width: 14, height: 14)
                        .foregroundColor(
                            index == currentIndex
                            ? .white
                            : .white.opacity(0.3)
                        )
                }
            }

            // Main content inside card
            content

        }
        .frame(width: 602, height: 782)
        .background(
            RoundedRectangle(cornerRadius: 69)
                .foregroundStyle(color)
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 9, y: 30)
                .overlay(
                    Image("pattern")
                        .resizable()
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
    let onPlay: () -> Void
    
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
                //changed width and height
                    .frame(width: 343, height: 514)
                    .cornerRadius(16)
            }
            Button(action: {
                onPlay()
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
        }
    }
}


struct StepFlowView: View {
    @State private var currentIndex = 0
    
    let steps: [StepModel] = [
        StepModel(
            title: "Brushing Teeth",
            description: "Children brush their teeth twice a day\nwith their beautiful toothbrushes.",
            imageName: "brushingTeeth1",
            color: .bluey
        ),
        StepModel(
            title: "Washing Hands",
            description: "Wash hands with soap after using the bathroom.",
            imageName: "brushingTeeth2",
            color: .bluey
        ),
        StepModel(
            title: "Washing Hands",
            description: "Wash hands with soap after using the bathroom.",
            imageName: "brushingTeeth3",
            color: .bluey
        ),
        StepModel(
            title: "Washing Hands",
            description: "Wash hands with soap after using the bathroom.",
            imageName: "brushingTeeth4",
            color: .bluey
        ),
    ]
    
    var body: some View {
        StepCard(
            color: steps[currentIndex].color,
            currentIndex: currentIndex,
            totalSteps: steps.count
        ) {
            StepCardContent(
                title: steps[currentIndex].title,
                description: steps[currentIndex].description,
                imageName: steps[currentIndex].imageName,
                onPlay: {
                    if currentIndex < steps.count - 1 {
                        currentIndex += 1
                    }
                }
            )
        }
    }
}



struct EatingFoodCardsView: View {
    @State private var currentIndex = 0
    @Binding var selectedCard: String?

    let steps: [StepModel] = [
        StepModel(
            title: "Eating Food",
            description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.",
            imageName: "hungry",
            color: .yellowey
        ),
        StepModel(
            title: "Eating Food",
            description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.",
            imageName: "thinkingOfFood",
            color: .yellowey
        ),
        StepModel(
            title: "Eating Food",
            description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.",
            imageName: "FindanApple",
            color: .yellowey
        ),
        StepModel(
            title: "Eating Food",
            description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.",
            imageName: "eatinganApple",
            color: .yellowey
        ),
        StepModel(
            title: "Eating Food",
            description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.",
            imageName: "fullStom.",
            color: .yellowey
        ),
    ]
    
    var body: some View {
        StepCard(
            color: steps[currentIndex].color,
            currentIndex: currentIndex,
            totalSteps: steps.count
        ) {
            StepCardContent(
                title: steps[currentIndex].title,
                description: steps[currentIndex].description,
                imageName: steps[currentIndex].imageName,
                onPlay: {
                    if currentIndex < steps.count - 1 {
                        currentIndex += 1
                    }
                }
            )
        }
    }
}

#Preview {
    @Previewable @State var selectedCard: String? = nil
    return Cards(selectedCard: $selectedCard)
}
