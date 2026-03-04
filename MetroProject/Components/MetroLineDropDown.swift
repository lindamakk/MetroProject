//
//  MetroLineDropDown.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI
//import SwiftData

enum DropDownPickerState {
    case top
    case bottom
}

struct MetroLineDropDown: View {
    let metroLine: MetroLine
    var state: DropDownPickerState = .bottom

    @State private var showDropdown = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0

    let selectedStations: [MetroStation]
    let onSelectStation: (MetroStation) -> Void

    var body: some View {
        VStack(spacing: 0) {
            if state == .top && showDropdown { optionsView }
            headerView
                .zIndex(10)
            if state == .bottom && showDropdown { optionsView }
        }
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
        )
        .zIndex(zIndex)
    }
}

private extension MetroLineDropDown {
    var headerView: some View {
        HStack(spacing: 8) {
            Divider()
                .frame(width: 3, height: showDropdown ? 0 : 30)
                .background(getMetroColor(lineColor: metroLine.nameEn))

            Image(systemName: "tram")
                .foregroundColor(getMetroColor(lineColor: metroLine.nameEn))
                .padding(4)
                .background(getMetroColor(lineColor: metroLine.nameEn).opacity(0.2))
                .cornerRadius(10)
                .offset(x: showDropdown ? -15 : 0)

            Text(metroLine.nameEn)
                .foregroundColor(.black)
                .offset(x: showDropdown ? -15 : 0)
            Spacer()

            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(showDropdown ? 180 : 0))
        }
        .animation(.default, value: showDropdown)
        .padding()
        .frame(height: 70)
        .onTapGesture {
            index += 1
            zIndex = index
            withAnimation(.default) { showDropdown.toggle() }
        }
    }

    var optionsView: some View {
        let sortedStations = metroLine.stations.sorted { $0.sequence < $1.sequence }

        return HStack(alignment: .top, spacing: 10) {
            Divider() 
                .frame(width: 3, height: CGFloat(sortedStations.count) * 50)
                .background(getMetroColor(lineColor: metroLine.nameEn))

            VStack(spacing: 10) {
                ForEach(sortedStations, id: \.id) { station in
                    StationCard(
                        lineColor: getMetroColor(lineColor: station.line?.nameEn ?? "Gray"),
                        stopName: station.nameEn,
                        isSelected: selectedStations.contains(where: { $0.id == station.id })
                    )
                    .onTapGesture {
                        onSelectStation(station)
                    }
                }
            }
        }
        .padding(.all, 10)
        .transition(.move(edge: state == .top ? .bottom : .top))
    }
}

