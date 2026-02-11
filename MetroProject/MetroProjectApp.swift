//
//  MetroProjectApp.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import SwiftData

@main
struct MetroProjectApp: App {

    @State var path = NavigationPath()
    
    
    // CREATED ONCE
    let container: ModelContainer
    
    // Data
    init() {
            do {
                // We tell SwiftData: "These are the 3 models we want to save"
                container = try ModelContainer(for: MetroStation.self, MetroLine.self, TripHistory.self)
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                HomeView(path: $path)
                    .navigationDestination(for: String.self)
                {
                    value in
//                    if value == "Home" {
//                        HomeView(path: $path)
//                    }
                         if value == "SelectStops" {
                            SelectStopsView(path: $path)
                        }
                    else if value == "CurrentTrip" {
                        CurrentTripView(path: $path)
                    }
                    else if value == "TripEnded" {
                        TripEndedView(path: $path)
                    }
                }
            }
            // Data - inject the db into the entire app.
            .modelContainer(container)
            
            .onAppear {
                        DataService.seedData(context: container.mainContext)
                    }
        }
    }
}



