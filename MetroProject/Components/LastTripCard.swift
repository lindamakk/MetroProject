//
//  LastTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct LastTripCard: View {
    let stationName: String

    var metroColor: Color = .red

    var body: some View {
        Button(action: {
            // لسا ما تشتغل
        }) {
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
            .frame(maxWidth: .infinity, minHeight: 68, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
            )
        }
        .buttonStyle(.plain) // يحافظ على الشكل بدون تأثيرات زر افتراضية
        .contentShape(RoundedRectangle(cornerRadius: 12)) // يضمن أن كل مساحة الكرت قابلة للضغط
    }
}

#Preview("LastTripCard") {
    VStack(spacing: 20) {
        LastTripCard(stationName: "King Saud University")
    }
    .padding()
}
