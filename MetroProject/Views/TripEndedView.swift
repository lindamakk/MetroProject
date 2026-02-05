// Dana


import SwiftUI

struct TripEndedView: View {
    var body: some View {
     
        VStack {
            
            // icon
            ZStack {
                Circle()
                    .fill(Color("GreenPrimaryColor"))
                    .frame(width: 104, height: 104)

                Image(systemName: "checkmark.circle.dotted" )
                    .foregroundStyle(Color("BackgroundColor"))
                    .font(.system(size: 52, weight: .regular))
                    .accessibilityLabel("Reach Destination")
            }
            
            // text
            Text("You’ve reached your destination successfully")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 5)
                .padding(.horizontal, 50)
            
            Text("Have a great Day!")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)
            
            
            // done button
            ActionButton(label: "Done") {
                print("Started")
            }
            .offset(x: 0, y: 205)
            
        }
    
        
        
      
    }
}

#Preview {
    TripEndedView()
}
