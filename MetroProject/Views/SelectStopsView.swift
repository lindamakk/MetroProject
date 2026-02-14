//
//  SelectStopsView.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//


import SwiftUI

struct SelectStopsView: View {
   @Binding var path: NavigationPath
    
    @StateObject  private  var tripVeiewModel = CurrentTripViewModel()
    
    var body: some View {
        // a list of MetroLine from mv
        @Previewable @State var metroLine1: MetroLineTest = MetroLineTest(lineColor: .blueLine, lineName: "Blue Line", stops: [  Station(lineColor: .blueLine, stopName: "Princess Noura University 1"),  Station(lineColor: .blueLine, stopName: "Princess Noura University 1"),  Station(lineColor: .blueLine, stopName: "Princess Noura University 1")])
        
        
        @Previewable @State var metroLine2: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine3: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine4: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        
        @Previewable @State var metroLine5: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
        @Previewable @State var metroLine6: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
        
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
                //start trip and navigate
                tripVeiewModel.startTrip()
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
