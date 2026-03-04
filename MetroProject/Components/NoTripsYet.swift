//
//  NoTripsYet.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI

struct NoTripsYet: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(red: 229/255, green: 230/255, blue: 225/255)) // E5E6E1
                    .frame(width: 96, height: 96)

                Image(systemName: "tram.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 255/255, green: 253/255, blue: 248/255)) // FFFDF8
            }

            Text("No Trips Yet")
                .font(.system(size: 14, weight: .regular, design: .default)) // SF Pro Text 14
                .foregroundColor(Color(red: 124/255, green: 119/255, blue: 119/255)) // 7C7777
        }
        .frame(maxWidth: .infinity, minHeight: 180)
    }
}

#Preview {
    NoTripsYet()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color(.systemBackground))
}
