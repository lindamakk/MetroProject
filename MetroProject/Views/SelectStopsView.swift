//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//


import SwiftUI

struct SelectStopsView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        // a list of MetroLine from mv
        @Previewable @State var metroLine1: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        
        @Previewable @State var metroLine2: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine3: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine4: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        
        @Previewable @State var metroLine5: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine6: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        VStack(){
//            SearchBar()

            
            ScrollView{

                
                VStack(){
                    MetroLineDropDown(
                        metroLine: $metroLine1
                    )
                    MetroLineDropDown(
                        metroLine: $metroLine2
                    )
                    MetroLineDropDown(
                        metroLine: $metroLine3
                    )
                    MetroLineDropDown(
                        metroLine: $metroLine4
                    )
                    MetroLineDropDown(
                        metroLine: $metroLine5
                    )
                    MetroLineDropDown(
                        metroLine: $metroLine6
                    )
                }.padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TripButtomSheet{
                path.append("CurrentTrip")
            }

        }
        
        .ignoresSafeArea(edges: .bottom) 

       
       // TripButtomSheet()
            //Text("SelectStopsView")
    }
    
}
#Preview {
    @Previewable @State var path = NavigationPath()
    SelectStopsView(path: $path)


}
