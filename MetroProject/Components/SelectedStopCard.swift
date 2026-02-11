import SwiftUI

import SwiftUI

struct SelectedStopCard: View {
    let stops: [MetroStation]
    let onDelete: (MetroStation) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stops, id: \.id) { station in
                    ZStack(alignment: .leading) {
                        Button {
                            onDelete(station)
                        } label: {
                            Text(station.nameEn)
                                .foregroundColor(.black)
                                .frame(width: 120, height: 48)
                                .background(Color("GrayColorCard"))
                                .cornerRadius(16)
                        }

                        Rectangle()
                            .foregroundColor(getMetroColor(lineColor: station.line?.nameEn ?? "Gray"))
                            .frame(width: 4, height: 28)
                            .cornerRadius(16)
                            .offset(x: 8)
                    }
                }
            }.padding(.horizontal)
            
        }
    }
}
