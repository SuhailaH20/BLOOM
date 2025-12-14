//
//  LevelPage.swift
//  BLOOM
//
//  Created by Suhaylah hawsawi on 23/06/1447 AH.
//

import SwiftUI

enum AppLevel: String, CaseIterable {
    case basic
    case medium
    case advanced

    var titleAR: String {
        switch self {
        case .basic: return "بسيط"
        case .medium: return "متوسط"
        case .advanced: return "متقدم"
        }
    }

    var ageRangeAR: String {
        switch self {
        case .basic: return "من ٣ إلى ٦ سنوات"
        case .medium: return "من ٦ إلى ٩ سنوات"
        case .advanced: return "من ٩ إلى ١٢ سنة فما فوق"
        }
    }
}

struct LevelPage: View {
    @State private var age: Int = 6
    @State private var goNext = false

    // حفظ اختيار المستوى في الجهاز
    @AppStorage("appLevel") private var storedLevelRaw: String = AppLevel.basic.rawValue

    private var levelFromAge: AppLevel {
        if age < 6 { return .basic }
        if age < 9 { return .medium }
        return .advanced
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer().frame(height: 40)

            Text("اختر عمر الطفل")
                .font(.system(size: 56, weight: .bold))
                .foregroundStyle(Color(red: 55/255, green: 55/255, blue: 55/255))

            Text("العمر: \(age)")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(Color.black.opacity(0.7))

            Stepper("", value: $age, in: 3...16)
                .labelsHidden()
                .scaleEffect(1.6)
                .padding(.horizontal, 80)

            // عرض المستوى الناتج
            VStack(spacing: 10) {
                Text("المستوى: \(levelFromAge.titleAR)")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundStyle(Color.black.opacity(0.75))

                Text(levelFromAge.ageRangeAR)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundStyle(Color.black.opacity(0.55))
            }
            .padding(.top, 10)

            Spacer().frame(height: 20)

            Button {
                storedLevelRaw = levelFromAge.rawValue
                goNext = true
            } label: {
                Text("التالي")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 260, height: 92)
                    .background(Color.babyBlue)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red:255/255,green:246/255,blue:236/255,opacity: 1.0))
        .ignoresSafeArea()
        .navigationDestination(isPresented: $goNext) {
            CategoryPage(level: AppLevel(rawValue: storedLevelRaw) ?? .basic)
        }
    }
}
