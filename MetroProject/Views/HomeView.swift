//
//  HomeView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("Plan Trip")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 24)
                .padding(.horizontal, 16)

            // الكرت الأول بمحاذاة الوسط
            HStack {
                Spacer()
                StartTripCard()
                Spacer()
            }

            Text("Last Trips")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
                .padding(.top, 8)
                .padding(.horizontal, 16)

            HStack {
                LastTripCard(stationName: "King Saud University")
                Spacer()
            }.padding()

            Spacer(minLength: 0)
        }
    }
}

#Preview {
    HomeView()
}
