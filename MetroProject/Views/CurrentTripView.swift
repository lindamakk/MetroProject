//
//  CurrentTripView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
struct CurrentTripView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel = CurrentTripViewModel()
    @State private var showEndTripAlert = false
    
    
    
    let currentUserDestination = userDestination(stationName: "King Saud University", lineName: "Red")
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer().frame(height: 40)
            // Pass the destination from ViewModel
            FinalDestinationGroup(
                userDestination: userDestination(
                    stationName: viewModel.destinationName,
                    lineName: "Red" // You might want to add line tracking to ViewModel
                )
            )
            
            // Pass remaining stations count from ViewModel
            TripCardView(
                stopsLeft: viewModel.stationsRemaining,
                status: .inProgress
            )
            
            
            
//            FinalDestinationGroup(userDestination: currentUserDestination)
//            TripCardView(stopsLeft: 2, status: .inProgress)
            
            //TripCardView(stopsLeft: 1, status: .interrupted)
            
            Spacer()
            
            //end trip button
            ActionButton(
                label: "End Trip") {
                print("End Trip")
                    showEndTripAlert = true
                    //add alert before
                       path.append("TripEnded")
                   

            }//button
            
        }//v
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 253/255, green: 254/255, blue: 255/255))
        .ignoresSafeArea()
        // TODO: we need to change alert to
        .alert("End Trip?", isPresented: $showEndTripAlert) {
            Button("Cancel", role: .cancel) { }
            Button("End Trip", role: .destructive) {
                viewModel.stopTrip() // Call the ViewModel method
                path.append("TripEnded")
            }
        } message: {
            Text("Are you sure you want to end your trip?")
        }
        .onDisappear {
            // Cleanup when view disappears
            if viewModel.isTrackingActive {
                viewModel.stopTrip()
            }
        }
        
        
        
        
    }//body
}//struct
#Preview {
    @Previewable @State var path = NavigationPath()
    CurrentTripView(path: $path)
}
