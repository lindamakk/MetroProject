//
//  TripButtomSheet.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI



struct TripButtomSheet: View {
    
    var body: some View {
       
            
            VStack(alignment: .leading, spacing: 4) {
                SelectedStopCard()
                    .padding()
                
                ActionButton(label: "Start Trip") {
                    print("Started")
                }
            }
            .padding(.bottom, 40)  // ✅ Space for safe area
            //.background(Color.white)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))  // ✅ iOS 16+
            .overlay(
                UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
            )
            //.shadow(radius: 4)

    }
}

//struct TripButtomSheet: View {
//    @State private var isPresented: Bool = true  // Shows immediately
//
//    var body: some View {
//        Color.clear  // Invisible view
//            .sheet(isPresented: $isPresented) {
//                ContentTripButtomSheet()
//                    .presentationDetents([.medium, .height(208)])
//                    .presentationDragIndicator(.visible)
//                    //.interactiveDismissDisabled(true)
//            }
//
//    }
//}
#Preview {


   TripButtomSheet()

}

//struct ContentTripButtomSheet : View{
//    var body: some View {
//        
//        VStack(alignment: .leading ){
//            SelectedStopCard()
//                .padding()
//            // 1 Default green button
//            ActionButton(label: "Start Trip") {
//                print("Started")
//            }
//            
//        }//v
//        
//       // .frame(maxHeight: .infinity, alignment: .top)
//    }
//}
