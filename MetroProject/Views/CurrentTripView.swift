import SwiftUI

struct CurrentTripView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel = CurrentTripViewModel()
    @State private var showEndTripAlert = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 40)
            
            // الوجهة القادمة
            FinalDestinationGroup(
                userDestination: userDestination(
                    stationName: viewModel.nextStationName,
                    lineName: viewModel.nextStationLine
                )
            )
            
            // كرت الرحلة (تلقائياً سيتعرف على "Trip in progress" و "Stops Left" إذا كانت داخل الكرت)
            TripCardView(
                stopsLeft: viewModel.stationsRemaining,
                status: .inProgress
            )
            
            Spacer()
            
            StopsProgressBar(viewModel: viewModel)
            
            Spacer()
            
            // زر إنهاء الرحلة
        
                ActionButton(label: "End Trip") {
                    showEndTripAlert = true
                }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
        
        // التنبيه (Alert) - هنا التعديل المهم للترجمة
        .alert(String(localized: "End Trip?"), isPresented: $showEndTripAlert) {
            Button(String(localized: "Cancel"), role: .cancel) { }
            Button(String(localized: "End Trip"), role: .destructive) {
                viewModel.stopTrip()
                path.append("TripEnded")
            }
        } message: {
            Text("Are you sure you want to end your trip?")
        }
        .onDisappear {
            if viewModel.isTrackingActive {
                viewModel.stopTrip()
            }
        }
    }
}
