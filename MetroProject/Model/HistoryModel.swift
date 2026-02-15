//
//  HistoryModel.swift
//  MetroProject
//
//  Created by Dana on 21/08/1447 AH.
//

import SwiftData
import Foundation

@Model
class TripHistory {
    @Attribute(.unique) var id: UUID = UUID()         // auto-generated
    var date: Date = Date()        // auto timestamp
//    var routeStations : [MetroStation]
//    var status: String
    @Relationship(inverse: \MetroStation.tripHistories)
        var routeStations: [MetroStation]
    
    init(routeStations: [MetroStation]) {
        self.id = UUID()
        self.date = Date()
        self.routeStations = routeStations
//        self.status = status
    }
}
