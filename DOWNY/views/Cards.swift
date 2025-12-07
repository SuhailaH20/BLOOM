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
                BrushingTeethCardsView()
                // BeingKindCardsView()
                
            case "brushingTeeth":
                BrushingTeethCardsView()
                
            case "brushingHair":
                BrushingTeethCardsView()
                //    BrushingHairCardsView()
                
            default:
                BrushingTeethCardsView()
            }
        }
        //        .background(backgroundImage())
        //    }
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
            VStack(spacing: -10){
                
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
                Spacer().frame(height: 30)
                content
                
                if currentIndex < totalSteps - 1 {
                    playButton
                }
            }
            .frame(width: 700, height: 1000)
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
            
        }
        
        private var playButton: some View {
            Button(action: onNext) {
                HStack {
                    Image(systemName: "play.fill")
                    Spacer().frame(width: 33)
                    Text("Play routine")
                }.font(.system(size: 48, weight: .bold))
                    .foregroundColor(.babyBlue)
                    .frame(width: 592, height: 123)
                    .background(Color.white.opacity(0.7))
                
                    .cornerRadius(100)
            }
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
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.babyBlue)
                    .multilineTextAlignment(.center)
                
                
                Text(step.description)
                    .font(.system(size: 48))
                    .foregroundColor(.babyYellow)
                    .multilineTextAlignment(.center)
                
                Image(step.imageName)
                    .resizable()
                    .frame(width: 349, height: 334)
                
            }.onAppear {
                if let audio = step.audioF {
                    AudioPlayerManager.shared.playSound(named: audio)
                }
            }
            // .onAppear {
            //            SpeechManager.shared.speak(step.description)
            //        }
            
        }
    }
    
    
    
    /****THE CARDS CONTENT  **/
    
    struct BrushingTeethCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "brush", title: "Brushing Teeth", description: "Apply toothapste \non their toothbrush.", imageName: "BT1", color: .babyBlue ,audioF: "BTV2.mp3"),
            StepModel(Icon: "brush",title: "Brushing Teeth", description: "Children brush their teeth gently.", imageName: "brushing2", color: .babyBlue,audioF: "BTV2.mp3"),
            StepModel(Icon: "brush", title: "Brushing Teeth", description: "Children rinse their mouths after brushing their teeth..", imageName: "brushing3", color: .babyBlue,audioF: "BTV2.mp3"),
            StepModel(Icon: " ", title: "Good Job", description: " ", imageName: "GJ", color: .babyBlue,audioF: "BTV2.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    
    
    
    struct EatingFoodCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "apple", title: "Eating food", description: "When we feel hungry, we listen to our tummy and know it’s time to eat.", imageName: "EatingFood1", color: .babyYellow,audioF: "EF1.mp3"),
            StepModel(Icon: "apple",title: "Eating food", description: "We sit at the table, choose our food, and take small bites to help our body feel good", imageName: "EatingFood2", color: .babyYellow,audioF: "EF2.mp3"),
            StepModel(Icon: "apple", title: "Eating food", description: "After we eat, our tummy feels happy and full, and we have energy to play and learn.", imageName: "EatingFood3", color: .babyYellow,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: "Good Job", description: " ", imageName: "GJ", color: .babyYellow,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    //
    //struct BeingKindCardsView: View {
    //
    //    let steps: [StepModel] = [
    //        StepModel(title: "Being kind", description: "When we meet our friends or family, we greet \nthem with a smile.", imageName: "smiley", color: .redey),
    //        StepModel(title: "Being kind", description: "We share, help, and use kind words because it makes everyone feel safe and happy.", imageName: "friend", color: .redey),
    //        StepModel(title: "Being kind", description: "Giving gifts makes our heart feels warm,\n and the people around us feel good too.", imageName: "gift", color: .redey),
    //        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .redey),
    //    ]
    //
    //    var body: some View {
    //        StepFlow(steps: steps) { step in
    //            StepCardContent(step: step)
    //        }
    //
    //        }
    //    }
    //
    //struct BrushingHairCardsView: View {
    //
    //    let steps: [StepModel] = [
    //        StepModel(title: "Combing hair", description: "Children feel upset when their hair gets messy.", imageName: "messyHair", color: .greeney),
    //        StepModel(title: "Combing hair", description: "Children brush their hair gently \nusing their beautiful brushes.", imageName: "combing", color: .greeney),
    //        StepModel(title: "Combing hair", description: "Children feel happy and confident after they \nfinish combing their hair.", imageName: "kind", color: .greeney),
    //        StepModel(title: "Good Job", description: " ", imageName: "GJ", color: .greeney),
    //    ]
    //
    //    var body: some View {
    //        StepFlow(steps: steps) { step in
    //            StepCardContent(step: step)
    //        }
    //
    //        }
    //    }
    
    
}

#Preview {
    @Previewable @State var selectedCard: String? = nil
    return Cards(selectedCard: $selectedCard)
}
