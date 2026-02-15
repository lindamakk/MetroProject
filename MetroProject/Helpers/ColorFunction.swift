//
//  ColorFunction.swift
//  MetroProject
//
//  Created by Linda on 10/02/2026.
//

import SwiftUI
// MARK: - Helper for line colors
func getMetroColor(lineColor: String) -> Color {
    switch lineColor.lowercased() {
    case "red line": return .red
    case "blue line": return .blue
    case "yellow line": return .yellow
    case "green line": return .green
    case "purple line": return .purple
    case "orange line": return .orange
    default: return .gray
    }
}
