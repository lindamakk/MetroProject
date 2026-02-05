//
//  LastTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct StatusCard: View {
    let stationName: String

    var metroColor: Color = .red

    var body: some View {
        HStack(spacing: 12) {

            RoundedRectangle(cornerRadius: 3.5, style: .continuous)
                .fill(metroColor)
                .frame(width: 7, height: 45)
                .accessibilityHidden(true)

            Text(stationName)
                .font(.system(size: 16, weight: .regular, design: .default)) // SF Pro Text 16
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .frame(width: 334, height: 68, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
    }
}

#Preview("StatusCard") {
    VStack(spacing: 20) {
        StatusCard(stationName: "King Saud University")
    }
    .padding()
}
