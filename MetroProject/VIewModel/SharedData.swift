//
//  SharedData.swift
//  MetroProject
//
//  Created by nouransalah on 23/08/1447 AH.
//

import Foundation
import Combine
//MARK: - 1. Shared Data Store
final class SharedData: ObservableObject {
    static let shared = SharedData()
    
    @Published var items: [MetroStationTEST] = [station1]
   // @Published var selectedStop:[MetroStation]=[]
    private init() {}
}

// Define the model
struct MetroStationTEST :  Hashable {
    let name: String
    let longitude: Double
    let latitude: Double
    let metroline: String

}

// Create 3 objects from your data
let station1 = MetroStationTEST(
    name: "Dr Sulaiman Al Habib",
    longitude: 46.725799350815485,
    latitude: 24.860932211685256,
    metroline: "Blue",
)

let station2 = MetroStationTEST(
    name: "KAFD",
    longitude: 46.72506156287345,
    latitude: 24.860485030428944,
    metroline: "Blue",
)

let station3 = MetroStationTEST(
    name: "King Fahad District 2",
    longitude: 46.66338701990518,
    latitude: 24.73665171554253,
    metroline: "Blue ",
)
