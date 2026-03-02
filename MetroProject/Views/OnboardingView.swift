//
//  OnboardingView.swift
//  MetroProject
//
//  Created by Dana on 12/09/1447 AH.
//

import SwiftUI
import CoreLocation

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    private let locationManager = CLLocationManager()
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            Image(systemName: "location.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(Color("GreenPrimaryColor"))
            
            Text("Never Miss Your Stops")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("To wake you up when you arrive at your station, Stoply needs to track your location.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            

                Text("Please select 'Always Allow' on the settings")
                    .font(.footnote)
                    .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                // Ask for the permission once.
                locationManager.requestAlwaysAuthorization()
                
                // Dismiss this screen, only showed once to the user.
                hasSeenOnboarding = true
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("GreenPrimaryColor"))
                    .cornerRadius(15)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
