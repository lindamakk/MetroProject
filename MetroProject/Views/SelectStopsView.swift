//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//


import SwiftUI

struct SelectStopsView: View {
    
    var body: some View {
        
        
        VStack(){
            SearchBar()
            
            
            ScrollView{
                
                @Previewable @State var metroLine1: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
                
                
                @Previewable @State var metroLine2: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
                
                @Previewable @State var metroLine3: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
                
                @Previewable @State var metroLine4: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
                
                
                @Previewable @State var metroLine5: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
                
                @Previewable @State var metroLine6: MetroLine = MetroLine(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])

                
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
            
            TripButtomSheet()

        }
        
        .ignoresSafeArea(edges: .bottom) 

       
       // TripButtomSheet()
            //Text("SelectStopsView")
    }
    
}
#Preview {

    SelectStopsView()


}
