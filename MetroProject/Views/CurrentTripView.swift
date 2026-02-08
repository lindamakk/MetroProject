import SwiftUI
struct CurrentTripView: View {
    
    let currentUserDestination = userDestination(stationName: "King Saud University", lineName: "Red")
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer().frame(height: 40)
            
            FinalDestinationGroup(userDestination: currentUserDestination)
            TripCardView(stopsLeft: 2, status: .inProgress)
            
            //TripCardView(stopsLeft: 1, status: .interrupted)
            
            Spacer()
            
            //end trip button
            ActionButton(
                label: "End Trip") {
                print("End Trip")
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 253/255, green: 254/255, blue: 255/255))
        .ignoresSafeArea()
    }
}
#Preview {
    CurrentTripView()
}
