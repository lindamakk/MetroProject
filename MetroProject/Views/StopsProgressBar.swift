//
//  Untitled.swift
//  MetroProject
//
//  Created by nouransalah on 14/09/1447 AH.
//
//
//  StopsProgressBar.swift
//  MetroProject
//

import SwiftUI

// MARK: - Main Component
struct StopsProgressBar: View {
    @ObservedObject var viewModel: CurrentTripViewModel

    private var stations: [MetroStation] { SharedData.shared.items }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Array(stations.enumerated()), id: \.element.id) { index, station in
                    StopNode(
                        name: station.displayName,
                        isPassed: viewModel.mapIsPassed[station] ?? false,
                        isNext: index == viewModel.currentStationIndex
                    )

                    if index < stations.count - 1 {
                        ConnectorLine(isPassed: viewModel.mapIsPassed[station] ?? false)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Single Stop Node
private struct StopNode: View {
    let name: String
    let isPassed: Bool
    let isNext: Bool

    private let green = Color("GreenPrimaryColor")

    private var circleColor: Color {
        if isNext    { return green }
        if isPassed  { return .gray.opacity(0.4) }
        return .white
    }

    private var borderColor: Color {
        if isNext    { return green }
        if isPassed  { return .gray.opacity(0.4) }
        return .gray
    }

    private var labelColor: Color {
        if isNext    { return green }
        if isPassed  { return .gray }
        return .primary
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: 18, height: 18)
                    .overlay(Circle().stroke(borderColor, lineWidth: isPassed ? 0 : 2))

                if isPassed {
                    Image(systemName: "checkmark")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                }

                if isNext {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 7, height: 7)
                }
            }

            Text(name)
                .font(.system(size: 10, weight: isNext ? .semibold : .regular))
                .foregroundColor(labelColor)
                .multilineTextAlignment(.center)
                .frame(width: 64)
                .lineLimit(2)
        }
    }
}

// MARK: - Connector Line
private struct ConnectorLine: View {
    let isPassed: Bool

    var body: some View {
        Rectangle()
            .fill(isPassed ? Color.gray.opacity(0.4) : Color.gray.opacity(0.25))
            .frame(width: 32, height: 2)
            .padding(.bottom, 28)
    }
}
