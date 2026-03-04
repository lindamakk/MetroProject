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
            Text(stopName)
                .font(.system(size: 14, weight: .medium))
                // لضمان أن النص يقلب أبيض في الدارك مود
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(height: 40)
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                // التعديل هنا:
                // إذا لم تكن مختارة، نستخدم الرمادي النظامي (systemGray4) لأنه يبرز في الدارك مود
                .stroke(isSelected ? lineColor : Color(.systemGray4),
                        lineWidth: isSelected ? 2 : 1)
        )
    }
}


#Preview {
    StationCard()
}
