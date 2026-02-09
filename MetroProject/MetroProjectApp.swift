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

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                HomeView(path: $path)
                    .navigationDestination(for: String.self)
                {
                    value in
                    if value == "Home" {
                        HomeView(path: $path)
                    }
                        if value == "SelectStops" {
                            SelectStopsView(path: $path)
                        }
                    if value == "CurrentTrip" {
                        CurrentTripView(path: $path)
                    }
                    if value == "TripEnded" {
                        TripEndedView(path: $path)
                    }
                    }
            }
        }
    }
}



