import SwiftUI
import CoreLocation

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0
    
    private let locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                
                // Screen 1
                OnboardingStepView(
                    image: "figure.walk",
                    title: "On your way to school or work?",
                    subtitle: "Select the metro stops for your trip."
                )
                .tag(0)
                
                // Screen 2
                OnboardingStepView(
                    image: "moon.zzz.fill",
                    title: "Relax and enjoy the ride.",
                    subtitle: "Scroll, read, or even take a nap."
                )
                .tag(1)
                
                // Screen 3
                OnboardingStepView(
                    image: "bell.badge.fill",
                    title: "We’ve got your stop.",
                    subtitle: "We’ll remind you before you arrive — no more missed stations."
                )
                .tag(2)
                
                // Location Permission Screen
                VStack(spacing: 16) {
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
                    
                    Text("To remind you before your station, Stoply needs access to your location.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Text("Please choose “Always Allow” in the next step.")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            Button(action: {
                if currentPage < 3 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    locationManager.requestAlwaysAuthorization()
                    hasSeenOnboarding = true
                }
            }) {
                Text(currentPage == 3 ? "Get Started" : "Continue")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("GreenPrimaryColor"))
                    .cornerRadius(15)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }
}

// التعديل السحري هنا عشان Xcode يلقط النصوص
struct OnboardingStepView: View {
    let image: String
    let title: LocalizedStringKey // غيرنا النوع هنا
    let subtitle: LocalizedStringKey // وغيرنا النوع هنا
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(Color("GreenPrimaryColor"))
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}
