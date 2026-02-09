//
//  MetroModels.swift
//  MetroProject
//
//  Created by Dana on 21/08/1447 AH.
//
import SwiftData
import Foundation
import CoreLocation

@Model
class MetroStation {
    // Use the code attribute as the id.
    @Attribute(.unique) var id: String
    
    var nameEn: String
    var nameAr: String
    var lineCode: String
    var sequence: Int
    var typeName: String
    
    var lat: Double
    var lon: Double
    
    var line: MetroLine?
    

    init(id: String, nameEn: String, nameAr: String, lineCode: String, sequence: Int, typeName: String, lat: Double, lon: Double) {
        self.id = id
        self.nameEn = nameEn
        self.nameAr = nameAr
        self.lineCode = lineCode
        self.sequence = sequence
        self.typeName = typeName
        self.lat = lat
        self.lon = lon
    }
}

@Model
class MetroLine {
    // Use the code attribute as the id.
    @Attribute(.unique) var code: String
    var nameEn: String
    
    // A line has many stations.
    // If you delete the Blue Line, the station stays but station.line becomes nil.
    @Relationship(deleteRule: .nullify, inverse: \MetroStation.line)
    var stations: [MetroStation] = []
    
    init(code: String, nameEn: String) {
        self.code = code
        self.nameEn = nameEn
    }
}
