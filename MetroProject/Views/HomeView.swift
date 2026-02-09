//
//  HomeView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("Plan Trip")
                .font(.system(size: 28, weight: .semibold))
                .padding(.top, 24)
                .padding(.horizontal, 16)

            HStack {
                Spacer()

             
                StartTripCard {
                    path.append("SelectStops")
                }

                Spacer()
            }

            Text("Last Trips")
                .font(.system(size: 16))
                .padding(.horizontal, 16)

            HStack {
                LastTripCard(stationName: "King Saud University")
                Spacer()
            }
            .padding()

            Spacer(minLength: 0)
        }
    }
}


#Preview {
    @Previewable @State var path = NavigationPath()
    HomeView(path: $path)
}
