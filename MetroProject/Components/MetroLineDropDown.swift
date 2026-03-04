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
        .background(Color("MainCardColor"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .zIndex(zIndex)
    }
}

private extension MetroLineDropDown {
    var headerView: some View {
        HStack(spacing: 8) {
            Divider()
                .frame(width: 3, height: showDropdown ? 0 : 30)
            // للألوان نستخدم nameEn دائمًا لأن الدالة تعرفها
                .background(getMetroColor(lineColor: metroLine.nameEn))
            
            Image(systemName: "tram")
                .foregroundColor(getMetroColor(lineColor: metroLine.nameEn))
                .padding(4)
                .background(getMetroColor(lineColor: metroLine.nameEn).opacity(0.2))
                .cornerRadius(10)
                .offset(x: showDropdown ? -15 : 0)
            
            // للنص نستخدم displayName عشان يقلب عربي
            Text(metroLine.displayName)
                .foregroundColor(.primary)
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
                .frame(width: 3, height: CGFloat(sortedStations.count) * 52)
                .background(getMetroColor(lineColor: metroLine.nameEn))
            
            VStack(spacing: 10) {
                ForEach(sortedStations, id: \.id) { station in
                    StationCard(
                        // هنا بنجبره ياخذ نفس اللون اللي مستخدمينه في الـ Divider والـ Image فوق
                        lineColor: getMetroColor(lineColor: metroLine.nameEn),
                        stopName: station.displayName,
                        // تأكدي إن هالسطر يطابق الـ ID صح
                        isSelected: selectedStations.contains(where: { $0.id == station.id })
                    )
                    .onTapGesture {
                        // جربي تضغطين هنا، لو ما قلب لون يعني الـ onSelectStation فيها مشكلة
                        onSelectStation(station)
                    }
                }
            }
        }
        .padding(.all, 10)
        .transition(.move(edge: state == .top ? .bottom : .top))
    }
}
