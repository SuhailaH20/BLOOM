import SwiftUI

struct BoardPage: View {
    var body: some View {
            
            VStack {
                Image("Title")
                Spacer().frame(height: 42)
                
                AllCards()
            }
            .background(backgroundImage())
    }
}

struct AllCards: View {
    var body: some View {
        VStack(spacing: 42) {
            ColorCard(color: .yellowey) {
                CardContent(
                    imageName: "eating",
                    title: "Eating food",
                    description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes."
                )
            }
            
            ColorCard(color: .redey) {
                CardContent(
                    imageName: "Image",
                    title: "Being kind",
                    description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes."
                )
            }
            
            ColorCard(color: .greeney) {
                CardContent(
                    imageName: "Image",
                    title: "Combing hair",
                    description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes."
                )
            }
            
            ColorCard(color: .bluey) {
                CardContent(
                    imageName: "brushingTeeth4",
                    title: "Brushing teeth",
                    description: "Children brush their teeth twice a day \nwith their beautiful toothbrushes."
                )
            }
        }
    }
}

//Resuable cards **you just need to send the color and the content**

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
            .shadow(color: Color.black.opacity(0.25), radius: 10, x: 9, y: 4)
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
                
                Spacer().frame(height: 12)
                
                Text(description)
                    .font(.system(size: 18, weight: .regular))
            }
        }
    }
}

#Preview {
    BoardPage()
}
