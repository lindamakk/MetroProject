//
//  StartTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct StartTripCard: View {
    var nav: () -> Void
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


            // In-card button
            ActionButton(
                label: "Add Your Stops",
                icon: "plus",
                width: 228,
               height: 44,
                
                
            )
            {
                nav()
            }
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
    
    
    
//    func nav(){}
}

#Preview("StartTripCard") {
    VStack {
        StartTripCard {
            print("Add Your Stops tapped")
        }
    }
    .padding()
}
