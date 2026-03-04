//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import SwiftData
import TipKit

struct SelectStopsView: View {

    @Environment(\.modelContext) var context
    @Binding var path: NavigationPath
    @EnvironmentObject var vm: SelectedStopViewModel
    
    @Environment(\.modelContext) private var modelContext
    
    let locationTip = LocationPermissionTip()

    @Query(sort: \MetroLine.code)
    private var metroLines: [MetroLine]

    var body: some View {
        VStack{
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {   VStack(alignment: .leading, ) {
                    Text("Choose your stops")
                        .font(.system(size: 28, weight: .semibold))
                    
                    Text("Select stops to receive notifications.")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                }
                

            
                    TipView(ChooseStopsTip())
//                        .tint(Color("GreenPrimaryColor"))


    
                VStack(spacing: 16) {
                    ForEach(metroLines, id: \.code) { line in
                        MetroLineDropDown(
                            metroLine: line,
                            selectedStations: vm.selectedStops,
                            onSelectStation: { vm.toggle($0) }
                        )
                    }
                }

            } .padding()  } 

            TripButtomSheet(
                listIsEmpty: vm.selectedStops.isEmpty,
                nav: {
                    vm.startTrip(context: context) //save in histor and in shared data
                    path.append("TripRecap")
                },
                stops: vm.selectedStops,
                onDelete: { vm.remove($0) }
            )
            .popoverTip(locationTip, arrowEdge: .bottom)
            
        }
        .background(Color("BackgroundColor").ignoresSafeArea())    }
}
//
//#Preview {
//    @Previewable @State var path = NavigationPath()
//    SelectStopsView(path: $path)
//}
