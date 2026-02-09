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
    var id: UUID
    var date: Date
    
    var startStation: MetroStation
    var endStation: MetroStation
    
    // "Completed", "Cancelled"
    var status: String 
    
    init(startStation: MetroStation, endStation: MetroStation, status: String = "Completed") {
        self.id = UUID()
        self.date = Date()
        self.startStation = startStation
        self.endStation = endStation
        self.status = status
    }
}
