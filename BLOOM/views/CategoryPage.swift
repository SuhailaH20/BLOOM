//
//  CategoryPage.swift
//  BLOOM
//
//  Created by Suhaylah hawsawi on 23/06/1447 AH.
//

import SwiftUI

struct CategoryPage: View {
    
    var body: some View {
        VStack(spacing: 40) {
            
            Spacer().frame(height: 40)
            
            Text("اختر الفئة")
                .font(.system(size: 56, weight: .bold))
                .foregroundStyle(Color(red: 55/255, green: 55/255, blue: 55/255))
            
            Spacer().frame(height: 30)
            
            // سلوكي
            NavigationLink { BoardPage(category: .behavioral) }
            label: {
                CategoryCard(
                    title: "سلوكي",
                    color: .babyBlue,
                    icon: "figure.walk"
                )
            }
            
            // تعليمي
            NavigationLink { BoardPage(category: .educational) }
            label: {
                CategoryCard(
                    title: "تعليمي",
                    color: .babyYellow,
                    icon: "book.fill"
                )
            }
            
            // انفعالي
            NavigationLink { BoardPage(category: .emotional) }
            label: {
                CategoryCard(
                    title: "انفعالي",
                    color: .green.opacity(0.7),
                    icon: "heart.fill"
                )
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red:255/255,green:246/255,blue:236/255))
        .ignoresSafeArea()
    }
}
struct CategoryCard: View {
    let title: String
    let color: Color
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 42)
            .fill(color)
            .frame(width: 600, height: 160)
            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
            .overlay(
                HStack(spacing: 30) {
                    Image(systemName: icon)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                    
                    Text(title)
                        .font(.system(size: 54, weight: .bold))
                        .foregroundColor(.white)
                }
            )
    }
}

#Preview {
    CategoryPage()
}
