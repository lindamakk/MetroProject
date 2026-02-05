//
//  StartTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct StartTripCard: View {
    // Colors from spec
    private let cardBackground = Color.white // #FFFFFF
    private let green = Color(red: 0x38/255, green: 0x66/255, blue: 0x41/255) // #386641
    private let subtitleGray = Color(red: 0x7C/255, green: 0x77/255, blue: 0x77/255) // #7C7777
    private let titleColor = Color.black // #000000

    // Action for the button
    var onAddStops: () -> Void = {}

    var body: some View {
        VStack (spacing: 10) {
            // Top icon circle
            ZStack {
                RoundedRectangle(cornerRadius: 27, style: .continuous)
                    .fill(green)
                    .frame(width: 56, height: 54)

                Image(systemName: "tram.fill" )
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, weight: .regular))
                    .accessibilityLabel("Start Trip")
            }
            .padding(.top, 20)

            // Title
            Text("Start Fresh")
                .font(.system(size: 16, weight: .regular, design: .default))
                .foregroundColor(titleColor)

            // Subtitle
            Text("Choose your stops and build your trip")
                .font(.system(size: 12, weight: .regular, design: .default))
                .foregroundColor(subtitleGray)

            Spacer(minLength: 0)

            // In-card button
            Button(action: onAddStops) {
                HStack(spacing: 8) {
                    Text("+ Add Your Stops")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 225, minHeight: 39)
                .background(green)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .frame(width: 334, height: 229)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(cardBackground)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
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
