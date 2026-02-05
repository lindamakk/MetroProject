//
//  SwiftUIView.swift
//  MetroProject
//
//  Created by Asayl Hussien on 15/08/1447 AH.
//
import SwiftUI

enum TripStatus {
    case inProgress
    case interrupted
}

// MARK: الكارد
struct TripCardView: View {
    let stopsLeft: Int
    let status: TripStatus
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(stopsLeft)")
                .font(.system(size: 60, weight: .medium))
                .foregroundColor(Color(red: 56/255, green: 102/255, blue: 65/255))
            
        
            Text("Stops Left")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 56/255, green: 102/255, blue: 65/255))
                .padding(2)
            
            // حالة الرحلة (Badge)
            TripStatusBadge(status: status)
            
            Spacer()
                .frame(height: 3)
            
            // البروقرس
            TripProgressIndicator()
        }
        .frame(width: 353, height: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 20)
    }
}

// MARK: Badge للحالة
struct TripStatusBadge: View {
    let status: TripStatus
    
    var body: some View {
        HStack(spacing: 8) {
            Text(status == .inProgress ? "Trip in progress" : "Trip interrupted")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: status == .inProgress ? "location.fill" : "location.slash.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(status == .inProgress ? Color(red: 106/255, green: 153/255, blue: 78/255) : Color(red:  233/255, green: 21/255, blue: 45/255))
                .frame(width: 136, height: 34)
        )
    }
}




// MARK: - Preview
struct TripCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            TripCardView(stopsLeft: 2, status: .inProgress)
         // TripCardView(stopsLeft: 2, status: .interrupted)
        }
    }
}

