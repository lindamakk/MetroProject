import SwiftUI

struct TripRecapView: View {
    @Binding var path: NavigationPath
    @ObservedObject private var shared = SharedData.shared
    @StateObject private var tripVeiewModel = CurrentTripViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if shared.items.isEmpty {
                    Spacer()
                    Text("No stops selected yet.")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(Array(shared.items.enumerated()), id: \.element.id) { index, station in
                            HStack(spacing: 12) {
                                Circle()
                                    .fill(getMetroColor(lineColor: station.lineName))
                                    .frame(width: 12, height: 12)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    // اسم المحطة بالعربي (من الـ Extension الخاص بك)
                                    Text(station.displayName)
                                        .font(.headline)
                                    
                                    // اسم المسار بالعربي (من الـ Extension الخاص بالـ MetroLine)
                                    // نستخدم التغليف الآمن لأن الـ line اختياري
                                    Text(station.line?.displayName ?? station.lineName)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("#\(index + 1)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .listStyle(.plain) // الآن في مكانها الصحيح بعد القوس الخاص بالـ List
                }
                
                // زر ابدأ الرحلة
                ActionButton(label: "Start Trip") {
                    tripVeiewModel.startTrip()
                    path.append("CurrentTrip")
                }
            }
            .navigationTitle("Your Trip Recap")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
