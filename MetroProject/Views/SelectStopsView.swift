//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import SwiftData

struct SelectStopsView: View {
    @StateObject  private  var tripVeiewModel = CurrentTripViewModel()
    @Environment(\.modelContext) var context
    @Binding var path: NavigationPath
    @EnvironmentObject var vm: SelectedStopViewModel
    
   // @EnvironmentObject var vmc: CurrentTripViewModel
//        @StateObject private var vm = SelectedStopViewModel()
    @Environment(\.modelContext) private var modelContext
    
    


    @Query(sort: \MetroLine.code)
    private var metroLines: [MetroLine]

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(metroLines, id: \.code) { line in
                        MetroLineDropDown(
                            metroLine: line,
                            selectedStations: vm.selectedStops,
                            onSelectStation: { vm.toggle($0) }
                        )
                    }
                }
                .padding()
            }

            TripButtomSheet(
                listIsEmpty: vm.selectedStops.isEmpty,
                
                nav: {
                    
                    vm.startTrip(context: context)
                    tripVeiewModel.startTrip()
                    path.append("CurrentTrip")
                    
                },
                stops: vm.selectedStops,
                onDelete: { vm.remove($0) }
               
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    SelectStopsView(path: $path)
}
