//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//


import SwiftUI
import SwiftData
import SwiftUI
import SwiftData

struct SelectStopsView: View {
    @Binding var path: NavigationPath
    @StateObject private var vm = SelectedStopViewModel()

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
                            onSelectStation: {
                            
                                vm.toggle($0) }
                        )
                    }
                }
                .padding()
            }

            TripButtomSheet(
                
                nav: {
                    print("grefwdqefdgh")
                    print(metroLines)
//                    print("Navigating to CurrentTrip")
//                    path.append("CurrentTrip")
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
