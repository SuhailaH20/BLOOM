//
//  ContentView.swift
//  DOWNY
//
//  Created by Suhaylah hawsawi on 03/06/1447 AH.
//

import SwiftUI

enum RoutineCategory: String {
    case behavioral   // سلوكي
    case educational  // تعليمي
    case emotional    // انفعالي
    
    var arabicTitle: String {
        switch self {
        case .behavioral:  return "سلوكي"
        case .educational: return "تعليمي"
        case .emotional:   return "انفعالي"
        }
    }
}

struct CardItem: Identifiable {
    let id = UUID()
    let selectionKey: String
    let imageName: String
    let title: String
    let description: String
    let color: Color
    let categories: [RoutineCategory]
}


struct BoardPage: View {
    let category: RoutineCategory
    @State private var selectedCard: String? = nil
    
    var body: some View {
        if selectedCard != nil {
            Cards(selectedCard: $selectedCard)
        } else {
            VStack {
                Spacer().frame(height: 42)
                Image("Title")
                Spacer().frame(height: 42)

                if category == .educational {
                    NumbersBoardView()
                } else {
                    AllCards(selectedCard: $selectedCard, category: category)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red:255/255,green:246/255,blue:236/255,opacity: 1.0))
            .ignoresSafeArea()
        }

    }
}


struct AllCards: View {
    @Binding var selectedCard: String?
    let category: RoutineCategory
    
    var body: some View {
        let items = allItems.filter { $0.categories.contains(category) }
        
        return ScrollView {
            VStack(spacing: 42) {
                ForEach(items) { item in
                    Button(action: {
                        selectedCard = item.selectionKey
                    }) {
                        ColorCard(color: item.color) {
                            CardContent(
                                imageName: item.imageName,
                                title: item.title,
                                description: item.description
                            )
                        }
                        .padding(.horizontal, 70)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    private var allItems: [CardItem] {
        [
           
            CardItem(
                selectionKey: "eatingFood",
                imageName: "eating",
                title: String(localized: "Eating food"),
                description: String(localized: "Children should eat healthy food to grow strong and stay active."),
                color: .babyBlue,
                categories: [.behavioral]
            ),
            CardItem(
                selectionKey: "brushingTeeth",
                imageName: "Brush",
                title: String(localized: "Brushing Teeth"),
                description: String(localized: "Children brush their teeth twice a day with their beautiful toothbrushes."),
                color: .babyBlue,
                categories: [.behavioral]
            ),
            CardItem(
                selectionKey: "brushingHair",
                imageName: "combing",
                title: String(localized: "Combing hair"),
                description: String(localized: "Children brush their hair and  take care of their look."),
                color: .babyBlue,
                categories: [.behavioral]
            ),
            CardItem(
                selectionKey: "Takingshower",
                imageName: "Shower",
                title: String(localized: "Taking Shower"),
                description: String(localized: "When children get dirty they take shower in order to be clean."),
                color: .babyBlue,
                categories: [.behavioral]
            ),
            CardItem(
                selectionKey: "Washing",
                imageName: "Washing",
                title: String(localized: "Washing Hands"),
                description: String(localized: "Children wash their hands before and after eating a meal."),
                color: .babyBlue,
                categories: [.behavioral]
            ),

          
            CardItem(
                selectionKey: "beingKind",
                imageName: "kind",
                title: String(localized: "Being Kind"),
                description: String(localized: "Children should be kind to others and treat them very well"),
                color: .babyYellow,
                categories: [.emotional]
            ),

       
            CardItem(
                selectionKey: "Screentime",
                imageName: "Screen",
                title: String(localized: "Screen Time"),
                description: String(localized: "When we use screen for way too long our eyes and brains get tired."),
                color: .babyYellow,
                categories: [.emotional]
            ),
            CardItem(
                selectionKey: "Sleep",
                imageName: "Sleep",
                title: String(localized: "Sleep Early"),
                description: String(localized: "children need enough sleep time to grow strong and healthy ."),
                color: .babyYellow,
                categories: [.emotional]
            )
        ]
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

struct NumbersBoardView: View {
    // Choose the range you want:
    // 0...9 (10 numbers) OR 1...10
    private let numbers = Array(1...9)

    // 3 columns Apple-style spacing
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 22),
        GridItem(.flexible(), spacing: 22),
        GridItem(.flexible(), spacing: 22)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 22) {
                ForEach(numbers, id: \.self) { num in
                    FlipNumberCard(
                        numberText: "\(num)",
                        imageName: "num_\(num)" // IMPORTANT: add these images to Assets
                    )
                }
            }
            .padding(.horizontal, 50)
            .padding(.top, 10)
            .padding(.bottom, 40)
        }
    }
}

struct FlipNumberCard: View {
    let numberText: String
    let imageName: String

    @State private var isFlipped = false

    var body: some View {
        ZStack {
            // Front (Text Number)
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.75))
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
                .overlay(
                    Text(numberText)
                        .font(.custom("RoarGuroes-Regular", size: 110))
                        .foregroundStyle(Color.green.opacity(0.7))
                )
                .opacity(isFlipped ? 0 : 1)

            // Back (Image)
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.75))
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(18)
                )
                .opacity(isFlipped ? 1 : 0)
                // rotate back face so it reads correctly after flip
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(width: 190, height: 190)
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.35), value: isFlipped)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

//#Preview {
//    BoardPage()
//}
