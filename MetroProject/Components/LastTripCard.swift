//
//  LastTripCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct LastTripCard: View {
    let history: TripHistory
    
    var nav: () -> Void
//    let stationName: String

//    var metroColor: Color = .red

    var body: some View {
        Button(action: {
            nav()
        }) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 3.5, style: .continuous)
                // السطر المعدل:
                .fill(getMetroColor(lineColor: history.routeStations.last?.line?.nameEn ?? "Gray"))
                .frame(width: 7, height: 45)
                    .accessibilityHidden(true)

                Text(history.routeStations.last!.displayName)
                    .font(.system(size: 16, weight: .regular))
                    // 💡 التعديل الأول: جعل النص يتكيف تلقائياً
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 68, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color("MainCardColor"))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
            )
        }
        .buttonStyle(.plain)
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }
}

//#Preview("LastTripCard") {
//    VStack(spacing: 20) {
//        LastTripCard(stationName: "King Saud University")
//    }
//    .padding()
//}
