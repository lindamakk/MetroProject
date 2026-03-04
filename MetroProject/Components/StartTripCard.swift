//
//  StartTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
struct StartTripCard: View {
    var nav: () -> Void
    
    private let cardBackground = Color("MainCardColor")
        private let green = Color("GreenPrimaryColor")
    
    private let titleColor = Color.primary // أسود في اللايت / أبيض في الداكن
    private let subtitleGray = Color.secondary // رمادي متكيف
    
    var onAddStops: () -> Void = {}

    var body: some View {
        VStack (spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 27, style: .continuous)
                    .fill(green)
                    .frame(width: 56, height: 54)

                Image(systemName: "tram.fill" )
                    .foregroundStyle(Color.white) // الترام يبقى أبيض داخل الدائرة الخضراء
                    .font(.system(size: 24, weight: .regular))
            }
            .padding(.top, 20)

            Text("Start Fresh")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(titleColor)

            Text("Choose your stops and build your trip")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(subtitleGray)

            ActionButton(
                label: "Add Your Stops",
                icon: "plus",
                width: 228,
                height: 44
            ) {
                nav()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 229)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(cardBackground)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
        .multilineTextAlignment(.center)
        .padding(.horizontal, 10)
    }
}
#Preview("StartTripCard") {
    VStack {
        StartTripCard {
            print("Add Your Stops tapped")
        }
    }
    .padding()
}
