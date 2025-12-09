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
                
            case "Takingshower":
                TakingShowerCardsView()
                
            case "Screentime":
                ScreenCardsView()
  
            case "Washing":
                WashingCardsView()
             
            case "Sleep":
                SleepCardsView()
                
            default:
                BrushingTeethCardsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red:255/255,green:246/255,blue:236/255,opacity: 1.0))
        .ignoresSafeArea()
        
    }
    
    
    
    struct StepCard<Content: View>: View {
        let color: Color
        let content: Content
        let currentIndex: Int
        let totalSteps: Int
        let onNext: () -> Void
        let onPlaySound: () -> Void
        
        init(
            color: Color,
            currentIndex: Int,
            totalSteps: Int,
            onNext: @escaping () -> Void,
            onPlaySound: @escaping () -> Void,
            @ViewBuilder content: () -> Content
        ) {
            self.color = color
            self.currentIndex = currentIndex
            self.totalSteps = totalSteps
            self.onNext = onNext
            self.onPlaySound = onPlaySound
            self.content = content()
        }
        
        var body: some View {
            VStack(spacing: -10){
                
                
                Spacer().frame(height: 30)
                content
                
                if currentIndex < totalSteps - 1 {
                    playButton
                }
                Spacer().frame(height: 70)
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
            Button(action: {
                onNext()
                onPlaySound()
            }){
                HStack {
                    Image(systemName: "play.fill")
                    Spacer().frame(width: 33)
                    Text("Play routine")
                }
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.black)
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
        @State private var firstStepPlayed = false
        
        var body: some View {
            StepCard(
                color: steps[currentIndex].color,
                currentIndex: currentIndex,
                totalSteps: steps.count,
                onNext: next,
                onPlaySound: playCurrentSound
            ) {
                content(steps[currentIndex])
            }
            .onAppear {
                playFirstStepSound()
            }
        }
        
        private func playFirstStepSound() {
            guard !firstStepPlayed else { return }
            firstStepPlayed = true
            
            if let audio = steps.first?.audioF {
                AudioPlayerManager.shared.playSound(named: audio)
            }
        }
        
        private func next() {
            if currentIndex < steps.count - 1 {
                currentIndex += 1
            }
        }
        
        private func playCurrentSound() {
            if let audio = steps[currentIndex].audioF {
                AudioPlayerManager.shared.playSound(named: audio)
            }
        }
    }
    
    
    
    
    
    struct StepCardContent: View {
        let step: StepModel
        
        var body: some View {
            VStack(spacing: 20) {
                
                Text(step.title)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundStyle(Color(red:55/255,green:55/255,blue:55/255,opacity: 1.0))
                    .multilineTextAlignment(.center)
                
                
                Text(step.description)
                    .font(.system(size: 40))
                    .foregroundStyle(Color(red:55/255,green:55/255,blue:55/255,opacity: 0.8))
                    .multilineTextAlignment(.center)
                
                Image(step.imageName)
                    .resizable()
                    .frame(width: 349, height: 334)
                
            }
            
            
        }
    }
    
    
    
    /****THE CARDS CONTENT  **/
    
    struct BrushingTeethCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "brush", title:String(localized: "Brushing Teeth"), description: String(localized:"Children apply toothapste on their toothbrush."), imageName: "BT1", color: .babyYellow ,audioF: "BTV2.mp3"),
            StepModel(Icon: "brush",title:String(localized: "Brushing Teeth"), description:String(localized: "Children brush their teeth gently."), imageName: "BT2", color: .babyYellow,audioF: "BTV2.mp3"),
            StepModel(Icon: "brush", title:String(localized: "Brushing Teeth"), description: String(localized:"Children rinse their mouths after brushing their teeth.."), imageName: "BT3", color: .babyYellow,audioF: "BTV2.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyYellow,audioF: "clap.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    
    
    
    struct EatingFoodCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "apple", title: String(localized:"Eating food"), description: String(localized:"When we feel hungry, we listen to our tummy and know it’s time to eat."), imageName: "EF1", color: .babyBlue,audioF: "EF1.mp3"),
            StepModel(Icon: "apple",title:String(localized: "Eating food"), description: String(localized:"We sit at the table, choose our food, and take small bites to help our body feel good"), imageName: "EF2", color: .babyBlue,audioF: "EF2.mp3"),
            StepModel(Icon: "apple", title:String(localized: "Eating food"), description:String(localized: "After we eat, our tummy feels happy and full, and we have energy to play and learn."), imageName: "EF3", color: .babyBlue,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title:String(localized: "Good Job"), description: " ", imageName: "GJ", color: .babyBlue,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    struct BeingKindCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Being Kind"), description:String(localized: "Children give a gift The child holds the gift and gives it kindly."), imageName: "BK1", color: .babyYellow,audioF: "EF1.mp3"),
            StepModel(Icon: "",title: String(localized:"Being Kind"), description: String(localized:"Children offer flowers to their families kindly, sharing warm smiles."), imageName: "BK2", color: .babyYellow,audioF: "EF2.mp3"),
            StepModel(Icon: "", title:String(localized: "Being Kind"), description:String(localized: "When we meet our friends or family, we greet them with a smile"), imageName: "BK3", color: .babyYellow,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyYellow,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    struct BrushingHairCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Combing hair"), description: String(localized:"Children brush their hair gently to remove the small tangles"), imageName: "CH1", color: .babyBlue,audioF: "EF1.mp3"),
            StepModel(Icon: "",title:String(localized: "Combing hair"), description: String(localized:"Then, they comb their hair slowly to make it smooth and tidy.")
                      , imageName: "CH2", color: .babyBlue,audioF: "EF2.mp3"),
            StepModel(Icon: "", title: String(localized:"Combing hair"), description: String(localized:"Finally, they fix their hair so it looks neat before they go out."), imageName: "CH3", color: .babyBlue,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyBlue,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
    struct TakingShowerCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Taking Shower"), description: String(localized:"When children get dirty they take shower in order to be clean."), imageName: "TS1", color: .babyBlue,audioF: "EF1.mp3"),
            StepModel(Icon: "",title:String(localized: "Taking Shower"), description:String(localized: "Children use shampoo and a warm water to clean themselves.")
                      , imageName: "TS2", color: .babyBlue,audioF: "EF2.mp3"),
            StepModel(Icon: "", title: String(localized:"Taking Shower"), description: String(localized:"Children dry themselves thoroughly with a clean towel and wear a clean clothes after."), imageName: "TS3", color: .babyBlue,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyBlue,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    struct ScreenCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Screen Time"), description: String(localized:"When we use screen for way too long our eyes and brains get tired."), imageName: "ST1", color: .babyYellow,audioF: "EF1.mp3"),
            StepModel(Icon: "",title:String(localized: "Screen Time"), description:String(localized: "We feel angry, so we turn off the screen."), imageName: "ST2", color: .babyYellow,audioF: "EF2.mp3"),
            StepModel(Icon: "", title: String(localized:"Screen Time"), description: String(localized:"After the break, our body feels relaxed and happy, and we can enjoy our day again."), imageName: "ST3", color: .babyYellow,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyYellow,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    struct WashingCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Washing Hands"), description: String(localized:"Children wash their hands before and after eating a meal."), imageName: "WH1", color: .babyBlue,audioF: "EF1.mp3"),
            StepModel(Icon: "",title:String(localized: "Washing Hands"), description:String(localized: "Children wash their hands after playing outside the house.")
                      , imageName: "WH2", color: .babyBlue,audioF: "EF2.mp3"),
            StepModel(Icon: "", title: String(localized:"Washing Hands"), description: String(localized:"So that the dirt has no chance of making them get sick."), imageName: "WH3", color: .babyBlue,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyBlue,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    struct SleepCardsView: View {
        
        let steps: [StepModel] = [
            StepModel(Icon: "", title: String(localized:"Sleep Early"), description: String(localized:"When it gets late, our body feels sleepy and needs rest to grow strong and healthy."), imageName: "SE1", color: .babyYellow,audioF: "EF1.mp3"),
            StepModel(Icon: "",title:String(localized: "Sleep Early"), description:String(localized: "We turn off screens, brush our teeth, and get into bed so our brain knows it’s time to sleep.")
                      , imageName: "SE2", color: .babyYellow,audioF: "EF2.mp3"),
            StepModel(Icon: "", title: String(localized:"Sleep Early"), description: String(localized:"We turn off screens, brush our teeth, and get into bed so our brain knows it’s time to sleep."), imageName: "SE3", color: .babyYellow,audioF: "EF3.mp3"),
            StepModel(Icon: " ", title: String(localized:"Good Job"), description: " ", imageName: "GJ", color: .babyYellow,audioF: "GJ.mp3"),
        ]
        
        var body: some View {
            StepFlow(steps: steps) { step in
                StepCardContent(step: step)
            }
            
        }
    }
    
}

#Preview {
    @Previewable @State var selectedCard: String? = nil
    return Cards(selectedCard: $selectedCard)
}
