// Dana

import SwiftUI

struct FinalDestinationGroup: View {
    var userDestination: userDestination
     
    
    var body: some View {
        VStack(spacing: 8){
            Text("Your Final Destination")
                .font(Font.system(size: 16, weight: .medium, design: .default))
            Text("\(userDestination.stationName)")
                .font(Font.system(size: 24, weight: .medium, design: .default))
            Text("\(userDestination.lineName) Line")
                .font(Font.system(size: 12, weight: .medium, design: .default))
                .foregroundColor(Color("GreenPrimaryColor"))
        }
      
        
    }
}


struct userDestination : Codable, Identifiable {
    var id = UUID()
    var stationName: String
    var lineName: String
    
}

#Preview {
    var CurrentUserDesination = userDestination(stationName: "King Saud University", lineName: "Red")
    FinalDestinationGroup(userDestination: CurrentUserDesination)
}
