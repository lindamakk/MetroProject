//
//  CurrentTripView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
struct CurrentTripView: View {
    @Binding var path: NavigationPath
    let currentUserDestination = userDestination(stationName: "King Saud University", lineName: "Red")
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer().frame(height: 40)
            
            FinalDestinationGroup(userDestination: currentUserDestination)
            TripCardView(stopsLeft: 2, status: .inProgress)
            
            //TripCardView(stopsLeft: 1, status: .interrupted)
            
            Spacer()
            
            //end trip button
            ActionButton(
                label: "End Trip") {
                print("End Trip")
                    //add alert before
                       path.append("TripEnded")
                   

            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 253/255, green: 254/255, blue: 255/255))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    @Previewable @State var path = NavigationPath()
    CurrentTripView(path: $path)
}
