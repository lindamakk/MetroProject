//
//  DataService.swift
//  MetroProject
//
//  Created by Dana on 21/08/1447 AH.
//

import SwiftData
import SwiftUI

@MainActor
class DataService {
    
    static func seedData(context: ModelContext) {
        // Check if data is already loaded.
        let descriptor = FetchDescriptor<MetroStation>()
        let existingStations = try? context.fetch(descriptor)
        
        if let count = existingStations?.count, count > 0 {
            print("✅ Database already populated. Skipping seed.")
            return
        }
        
        // Get the json file.
        guard let url = Bundle.main.url(forResource: "metro_data", withExtension: "json") else {
            print("❌ Error: Could not find metro_data.json in Bundle.")
            return
        }
        
        do {
            // Load and decode the json file.
            let data = try Data(contentsOf: url)
            let rawStations = try JSONDecoder().decode([JSONStation].self, from: data)
            
            // Temporary dictionary to avoid creating duplicate line objects.
            var linesCache: [String: MetroLine] = [:]
            
            
            for raw in rawStations {
                
                // Create the Line.
                let line: MetroLine
                if let existingLine = linesCache[raw.metroline] {
                    line = existingLine
                } else {
                    // If the dictionary does not include the line, create it.
                    let newLine = MetroLine(code: raw.metroline, nameEn: raw.metrolinename)
                    // Save to DB.
                    context.insert(newLine)
                    // Add line to cache for future checks.
                    linesCache[raw.metroline] = newLine
                    line = newLine
                }
                
                // Create the Station.
                let newStation = MetroStation(
                    id: raw.metrostationcode,
                    nameEn: raw.metrostationname,
                    nameAr: raw.metrostationnamear ?? "",
                    lineCode: raw.metroline,
                    sequence: raw.stationseq,
                    typeName: raw.mstationtypename,
                    lat: raw.geo_point_2d.lat,
                    lon: raw.geo_point_2d.lon
                )
                
                // Add the station to line.stations array.
                newStation.line = line
                
                // Save Station.
                context.insert(newStation)
            }
            
            // Save all loaded and created data.
            try context.save()
            print("✅ SUCCESS: Database seeded with \(rawStations.count) stations and \(linesCache.count) lines!")
            
        } catch {
            print("❌ Failed to seed data: \(error.localizedDescription)")
        }
    }
}
