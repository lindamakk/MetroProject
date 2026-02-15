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
    
//    @Query(sort: \TripHistory.date)
    @Query(sort: \TripHistory.date, order: .reverse)

    private var tripHistory: [TripHistory]
    
    var body: some View {
        ScrollView{ VStack(alignment: .leading, spacing: 24) {
            
            HStack(alignment: .center) {
                Text("Plan Trip")
                    .font(.system(size: 28, weight: .semibold))
//
//                Spacer()
//
//                Button(action: {
//                    print("change lang")
//                }) {
//                    Text("En")
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 4)
//
//                }
//                .foregroundColor(.gray)
//                .background(.grayColorCard)
//                .cornerRadius(10)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24) // ← move it here

            
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
                    // delete redundant from veiw
                    let uniqueHistory = tripHistory.reduce(into: [TripHistory]()) { result, trip in
                        // نتحقق إذا كان المسار (المحطات) موجود مسبقاً في النتائج
                        let alreadyExists = result.contains { existingTrip in
                            existingTrip.routeStations.map { $0.id } == trip.routeStations.map { $0.id }
                        }
                        if !alreadyExists {
                            result.append(trip)
                        }
                    }
                    
                    ForEach(uniqueHistory/*, id: \.self*/) { trip in
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
