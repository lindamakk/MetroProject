import Combine
import SwiftData
import Foundation


class SelectedStopViewModel: ObservableObject {
    @Published var selectedStops: [MetroStation] = []
    private let sharedData = SharedData.shared
    
    
    // Toggle selection: add/remove station
    func toggle(_ station: MetroStation) {
        if let index = selectedStops.firstIndex(where: { $0.id == station.id }) {
            selectedStops.remove(at: index)
        } else {
            selectedStops.append(station)
        }
    }
    
    // Remove a station
    func remove(_ station: MetroStation) {
        if let index = selectedStops.firstIndex(where: { $0.id == station.id }) {
            selectedStops.remove(at: index)
        }
    }
    
    func startTrip(context: ModelContext) {
        // save route in history
        DataService.addToHistory(context: context, history: selectedStops)

        // pass the stops list to SharedData if neede
        sharedData.items = selectedStops
    }}

