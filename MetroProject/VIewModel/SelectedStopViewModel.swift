import Combine

class SelectedStopViewModel: ObservableObject {
    @Published var selectedStops: [MetroStation] = []

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
}
