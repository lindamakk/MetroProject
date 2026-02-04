//
//  SelectedStopViewModel.swift
//  MetroProject
//
//  Created by nouransalah on 16/08/1447 AH.
//

import Combine

class SelectedStopViewModel: ObservableObject {
    @Published var selectedStopObjectarr: [MetroObject] = [obj1, obj4]

    //need binding so i can delete
    func removeCard(at index: Int) {
        selectedStopObjectarr.remove(at: index)
    }
}
//init(selectedStopObject: [MetroObject] = []) {
//    self.selectedStopObject = selectedStopObject
//}

// MARK: - Model
struct MetroObject: Codable, Identifiable {
    var id: String
    let metroLineColor: String
    let stopstationName: String
}
// MARK: - Sample Data
let obj1 = MetroObject(id: "1z1", metroLineColor: "BlueLine", stopstationName: "STC b")
let obj4 = MetroObject(id: "1z2", metroLineColor: "RedLine", stopstationName: "STC")
