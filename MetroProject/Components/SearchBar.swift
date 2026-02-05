// Dana
import SwiftUI

struct SearchBar: View {
    
    @State private var searchText = ""
    var body: some View {
            NavigationStack {
                List {
                    // TODO: List of stations
              
                }
                // must attack to a child view inside NavigationStack
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search for a station.."
                )
            }
           .frame(height: 120)
        }
}

#Preview {
    SearchBar()
}
