//
//  SelectedStopCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct SelectedStopCard: View {
    @StateObject private var selectedStopVM = SelectedStopViewModel()
    //@Binding var selectedStopObject: [MetroObject]
    //var deletecard : () -> Void
    var body: some View {
        HStack {
            // Array(enumerated())  will allow me to find  index and item
            //id: \.element.id i need it when i use  enumerated() so for ech know which property id
            //arr from vm
            ForEach(Array(selectedStopVM.selectedStopObjectarr.enumerated()), id: \.element.id) { index, item in
                ZStack(alignment: .leading) {
                    Button {
                        //here i call func to remove item
                        //removeCard(at: index)
                        selectedStopVM.removeCard(at: index)
                        
                        //func from mv to remove from original array
                    } label: {
                        Text(item.stopstationName)
                            .foregroundColor(.black)
                    }
                    .frame(width: 112, height: 48)
                    .background(Color("GrayColorCard"))
                    .cornerRadius(16)
                    
                    Rectangle()
                        .foregroundColor(Color(item.metroLineColor))
                        .frame(width: 4, height: 28)
                        .cornerRadius(16)
                        .offset(x: 8, y: 0)
                }
            }
        }
    }

}

//// MARK: - Model
//struct MetroObject: Codable, Identifiable {
//    var id: String
//    let metroLineColor: String
//    let stopstationName: String
//}

// MARK: - Preview
#Preview {
    //binding array

    //@Previewable @State var stops = [obj1, obj4]
    
    SelectedStopCard()
}

//// MARK: - Sample Data
//let obj1 = MetroObject(id: "1z1", metroLineColor: "BlueLine", stopstationName: "STC b")
//let obj4 = MetroObject(id: "1z2", metroLineColor: "RedLine", stopstationName: "STC")
//need binding so i can delete
//private func removeCard(at index: Int) {
//    selectedStopObject.remove(at: index)
//}
