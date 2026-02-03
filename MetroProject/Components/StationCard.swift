//
//  StationCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI

struct StationCard: View {
    
    var lineColor: Color = Color.yellow
    var stopName: String = "Princess Noura University 1"
    var isSelected: Bool = false
    var body: some View {

        
        
        VStack(alignment: .leading) {
            Text(stopName).font(Font.system(size: 14, weight: .medium, design: .default))
        }.padding()
            .frame(maxWidth: .infinity,  alignment: .leading)
            .frame(height: 40)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? lineColor : Color.gray, lineWidth: isSelected ? 2 : 1)).padding()
//
    
    }
}


#Preview {
    StationCard()
}
