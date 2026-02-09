//
//  MetroLineDropDown.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI


enum DropDownPickerState {
    case top
    case bottom
}

struct MetroLineDropDown: View {

    @Binding var metroLine: MetroLineTest
    var state: DropDownPickerState = .bottom

    @State private var showDropdown = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex = 1000.0
    @State var selectedStops: [Station] = [] // will use the mv one

    var body: some View {
        VStack(spacing: 0) {

            if state == .top && showDropdown {
                optionsView
            }

            headerView
                .zIndex(10)

            if state == .bottom && showDropdown {
                optionsView
            }
        }
        .background(Color.white)
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
                .overlay(.pink)

            Image(systemName: "tram").foregroundColor(metroLine.lineColor)


                    .padding(4)
                    .background(metroLine.lineColor.opacity(0.2)).cornerRadius(10)
                .offset(x: showDropdown ? -15 : 0) //postion of the icon
                

            Text(metroLine.lineName)
                .foregroundColor( .black) .offset(x: showDropdown ? -15 : 0)

            Spacer()

            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(showDropdown ? 180 : 0))
        }
        .animation(.snappy, value: showDropdown)
        .padding()
        .frame(height: 70)
        .onTapGesture {
            index += 1
            zIndex = index
            print(index)
            withAnimation(.snappy) {
                showDropdown.toggle()
            }
        }
    }
}


private extension MetroLineDropDown {

    var optionsView: some View {
        HStack(alignment: .top, spacing: 10) {

            Divider()
                .frame(width: 3,         height: CGFloat(metroLine.stops.count ) * 50 ) //so divider dont take all height
                .overlay(metroLine.lineColor)
                

            VStack(spacing: 10) {
                ForEach(metroLine.stops) { stop in
                    StationCard(
                        lineColor: stop.lineColor,
                        stopName: stop.stopName,
                        isSelected: selectedStops.contains(stop)
                    )
                    .onTapGesture {
                        withAnimation(.snappy) {
                            if let index = selectedStops.firstIndex(of: stop) {
                                
                                selectedStops.remove(at: index) //move to mv
                                print(selectedStops)
                            } else {
                                
                                selectedStops.append(stop)//move to mv
                                print(selectedStops)
                            }
                        }
                    }
                }
            }

        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        .transition(.move(edge: state == .top ? .bottom : .top))
    }
}


#Preview {
    @Previewable @State var metroLine: MetroLineTest = MetroLineTest(lineColor: .red, lineName: "Red Line", stops: [  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1"),  Station(lineColor: .red, stopName: "Princess Noura University 1")])
   
    MetroLineDropDown(
        metroLine: $metroLine
    ).padding()
}



struct MetroLineTest: Identifiable, Hashable {
    let id = UUID()
    let lineColor: Color
    let lineName: String
    let stops: [Station]
}

struct Station: Identifiable, Hashable {
    let id = UUID()
    let lineColor: Color
    let stopName: String
}

