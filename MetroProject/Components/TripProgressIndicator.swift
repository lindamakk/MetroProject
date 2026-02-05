//
//  TripTimeline.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI

struct TripProgressIndicator: View {
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(Color(red: 56/255, green: 102/255, blue: 65/255))
                .frame(width: 24, height: 24)
            
                
            
            Rectangle()
                .fill(Color(red: 56/255, green: 102/255, blue: 65/255))
                .frame(height: 7)
            
            Image("metro")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:24,height: 24)
                
                
            ZStack {
                Circle()
                    .fill(Color(red: 56/255, green: 102/255, blue: 65/255))
                    .frame(width: 24, height: 24)
                    .opacity(0.7)
                
              
                
            }
            
            Rectangle()
                .fill(Color(red: 56/255, green: 102/255, blue: 65/255))
                .frame(height: 7)
                .opacity(0.7)
            
            Circle()
                .fill(Color(red: 56/255, green: 102/255, blue: 65/255))
                .frame(width: 24, height: 24)
                .opacity(0.7)
        }
        .frame(maxWidth: 170
        )
    }
    
}
