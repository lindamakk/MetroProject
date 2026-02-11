//
//  TripButtomSheet.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI



struct TripButtomSheet: View {
    var listIsEmpty: Bool = true
    var nav: () -> Void
    let stops: [MetroStation]
    let onDelete: (MetroStation) -> Void
    var body: some View {
       
            
            VStack(alignment: .leading, spacing: 4) {
                SelectedStopCard(
                    stops: stops,
                    onDelete: onDelete
                )
                .padding(.top)
                
                ActionButton(label: "Start Trip", state:  listIsEmpty ? .disabled : .active) {
                    nav()
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
