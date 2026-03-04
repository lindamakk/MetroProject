import SwiftUI

struct NoTripsYet: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 96, height: 96)

                Image(systemName: "tram.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }

            Text("No Trips Yet")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 180)
    }
}
