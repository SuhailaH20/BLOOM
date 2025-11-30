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
        Group {
            switch selectedCard {
                
            case "eatingFood":
                EatingFoodCardsView()
                
            case "beingKind":
                BeingKindCardsView()
                
            case "brushingTeeth":
                BrushingTeethCardsView() 
                
            case "brushingHair":
                BrushingHairCardsView()
                
            default:
                Text("No card selected")
                    .foregroundColor(.gray)
            }
        }
        .background(backgroundImage())
    }
}



struct StepCard<Content: View>: View {
    let color: Color
    let content: Content
    let currentIndex: Int
    let totalSteps: Int
    let onNext: () -> Void

    init(
        color: Color,
        currentIndex: Int,
        totalSteps: Int,
        onNext: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.currentIndex = currentIndex
        self.totalSteps = totalSteps
        self.onNext = onNext
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 24) {

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

            content
        }
        .frame(width: 602, height: 782)
        .background(
            RoundedRectangle(cornerRadius: 69)
                .foregroundStyle(color)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 9, y: 30)
                .overlay(
                    Image("pattern")
                        .resizable()
                        .cornerRadius(69)
                        .opacity(0.08)
                )
        )
        .overlay(
            playButton,
            alignment: .bottomTrailing
        )
    }

    private var playButton: some View {
        Button(action: onNext) {
            HStack {
                Image(systemName: "play.fill").foregroundColor(.white)
                Text("Play").foregroundColor(.white)
            }
            .frame(width: 91, height: 50)
            .background(Color.red.opacity(0.8))
            .cornerRadius(100)
        }
        .padding(30)
    }
}



struct StepFlow<Content: View>: View {
    let steps: [StepModel]
    let content: (StepModel) -> Content
    
    @State private var currentIndex = 0
    
    var body: some View {
        StepCard(
            color: steps[currentIndex].color,
            currentIndex: currentIndex,
            totalSteps: steps.count,
            onNext: next
        ) {
            content(steps[currentIndex])
        }
    }
    
    private func next() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1
        }
    }
}



struct StepCardContent: View {
    let step: StepModel

    var body: some View {
        VStack(spacing: 20) {
            Text(step.title)
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text(step.description)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Image(step.imageName)
                .resizable()
                .frame(width: 343, height: 514)
                .cornerRadius(16)
        }
    }
}



/****THE CARDS CONTENT  **/

struct BrushingTeethCardsView: View {

    let steps: [StepModel] = [
        StepModel(title: "Brushing Teeth", description: "Children apply toothapste on their toothbrushe.", imageName: "BT1", color: .bluey),
        StepModel(title: "Brushing Teeth", description: "Children brush their teeth gently.", imageName: "BT2", color: .bluey),
        StepModel(title: "Brushing Teeth", description: "Children rinse their mouths after brushing their teeth..", imageName: "BT3", color: .bluey),
//        StepModel(title: "Brushing Teeth", description: "Wash hands with soap after using the bathroom.", imageName: "brushingTeeth4", color: .bluey),
        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .bluey),
    ]

    var body: some View {
        StepFlow(steps: steps) { step in
            StepCardContent(step: step)
        }

    }
}




struct EatingFoodCardsView: View {
    
    let steps: [StepModel] = [
        StepModel(title: "Eating Food", description: "When we feel hungry, we listen to our tummy \nand know it’s time to eat.", imageName: "hungry", color: .orangy),
//        StepModel(title: "Eating Food", description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.", imageName: "thinkingOfFood", color: .orangy),
//        StepModel(title: "Eating Food", description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.", imageName: "FindanApple", color: .orangy),
        StepModel(title: "Eating Food", description: "Children eat healthy food to grow strong\nand stay energetic throughout the day.", imageName: "eatinganApple", color: .orangy),
        StepModel(title: "Eating Food", description: "After we eat, our tummy feels happy and full,\n and we have energy to play and learn..", imageName: "fullStom.", color: .orangy),
        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .orangy),
    ]
    
    var body: some View {
        StepFlow(steps: steps) { step in
            StepCardContent(step: step)
        }

        }
    }


struct BeingKindCardsView: View {
    
    let steps: [StepModel] = [
        StepModel(title: "Being kind", description: "When we meet our friends or family, we greet \nthem with a smile.", imageName: "smiley", color: .redey),
        StepModel(title: "Being kind", description: "We share, help, and use kind words because it makes everyone feel safe and happy.", imageName: "friend", color: .redey),
        StepModel(title: "Being kind", description: "Giving gifts makes our heart feels warm,\n and the people around us feel good too.", imageName: "gift", color: .redey),
        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .redey),
    ]
    
    var body: some View {
        StepFlow(steps: steps) { step in
            StepCardContent(step: step)
        }

        }
    }

struct BrushingHairCardsView: View {
    
    let steps: [StepModel] = [
        StepModel(title: "Combing hair", description: "Children feel upset when their hair gets messy.", imageName: "messyHair", color: .greeney),
        StepModel(title: "Combing hair", description: "Children brush their hair gently \nusing their beautiful brushes.", imageName: "combing", color: .greeney),
        StepModel(title: "Combing hair", description: "Children feel happy and confident after they \nfinish combing their hair.", imageName: "kind", color: .greeney),
        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .greeney),
    ]
    
    var body: some View {
        StepFlow(steps: steps) { step in
            StepCardContent(step: step)
        }

        }
    }



#Preview {
    @Previewable @State var selectedCard: String? = nil
    return Cards(selectedCard: $selectedCard)
}
