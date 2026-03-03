//
//  MetroProjectApp.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct MetroProjectApp: App {

    @State var path = NavigationPath()
//    @EnvironmentObject var vm: SelectedStopViewModel
    @StateObject private var vm = SelectedStopViewModel()
    // Check if onboarding is complete
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
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
            try? Tips.configure()
        }

    var body: some Scene {
        WindowGroup {
            
            
            //SelectStopsView()
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
                    else if value == "TripRecap" {
                        TripRecapView(path: $path)
                    }
                    else if value == "CurrentTrip" {
                        CurrentTripView(path: $path)
                    }
                    else if value == "TripEnded" {
                        TripEndedView(path: $path)
                    }
                }
            }
            // Inject it into the entire stack
                        .environmentObject(vm)
            // Data - inject the db into the entire app.
            .modelContainer(container)
            
            .onAppear {
                        DataService.seedData(context: container.mainContext)
                    }
            
            // 4. Attach the Onboarding screen as a Full Screen Cover
                        .fullScreenCover(isPresented: Binding(
                            get: { !hasSeenOnboarding },
                            set: { _ in }
                        )) {
                            OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                        }
        }
    }
}



