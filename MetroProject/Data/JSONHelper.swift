//
//  JSONHelper.swift
//  MetroProject
//
//  Created by Dana on 21/08/1447 AH.
//

import Foundation

// Match the json file structure.
struct JSONStation: Codable {
    let metrostationcode: String
    let metrostationname: String
    let metrostationnamear: String
    let metroline: String
    let metrolinename: String
    let stationseq: Int
    let mstationtypename: String
    let geo_point_2d: JSONGeo
}

struct JSONGeo: Codable {
    let lat: Double
    let lon: Double
}
