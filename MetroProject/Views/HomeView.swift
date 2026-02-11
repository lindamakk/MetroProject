//
//  HomeView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import _SwiftData_SwiftUI


struct HomeView: View {
    
    @Binding var path: NavigationPath
    @EnvironmentObject var vm: SelectedStopViewModel
//        @StateObject private var vm = SelectedStopViewModel()
    
    @Query(sort: \TripHistory.date)
    private var tripHistory: [TripHistory]
    
    var body: some View {
        ScrollView{ VStack(alignment: .leading, spacing: 24) {
            
            Text("Plan Trip")
                .font(.system(size: 28, weight: .semibold))
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                StartTripCard {
                    vm.reset()
                    path.append("SelectStops")
                }
                
                Spacer()
            }
            
            Text("Last Trips")
                .font(.system(size: 16))
                .padding(.horizontal, 16)
            
            VStack {
                
                if tripHistory.isEmpty {
                    NoTripsYet()
                } else {
                    //                    LastTripCard(history: lastTrip)
                    
                    ForEach(tripHistory) { trip in
                        LastTripCard(history: trip){
                            vm.loadTrip(trip.routeStations)
                            path.append("SelectStops")
                        }
                        
                    }
                }
                
                Spacer()
            }  .padding(.horizontal, 16)
            
            Spacer(minLength: 0)
        }}
    }
}


//#Preview {
//    @Previewable @State var path = NavigationPath()
//    HomeView(path: $path)
//}
