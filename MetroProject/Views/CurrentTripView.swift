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
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer().frame(height: 40)
            
            FinalDestinationGroup(
                userDestination: userDestination(
                    stationName: viewModel.nextStationName,
                    lineName: viewModel.nextStationLine
                )
            )
            
            TripCardView(
                stopsLeft: viewModel.stationsRemaining,
                status: .inProgress
            )
            
            Spacer()
            
            ActionButton(
                label: "End Trip") {
                    showEndTripAlert = true
                }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // --- التعديل هنا ليدعم الدارك مود ---
        .background(Color("BackgroundColor").ignoresSafeArea())
        // ----------------------------------
        .alert("End Trip?", isPresented: $showEndTripAlert) {
            Button("Cancel", role: .cancel) { }
            Button("End Trip", role: .destructive) {
                viewModel.stopTrip()
                path.append("TripEnded")
            }
        } message: {
            Text("Are you sure you want to end your trip?")
        }
        .onDisappear {
            if viewModel.isTrackingActive {
                viewModel.stopTrip()
            }
        }
    }
}//struct
#Preview {
    @Previewable @State var path = NavigationPath()
    CurrentTripView(path: $path)
}
