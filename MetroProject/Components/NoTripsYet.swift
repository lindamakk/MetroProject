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
                    .fill(Color(.systemGray5))
                    .frame(width: 96, height: 96)
                
                Image(systemName: "tram.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color(.systemBackground))
            }
            
            Text("No Trips Yet")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.secondary)
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
