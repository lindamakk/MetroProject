// Dana
import SwiftUI

struct TripAlert: View {
    
    var text: String = "Trip Cancelled"
    var icon: String = "xmark.octagon"
    var iconColor: Color = Color("GreenPrimaryColor")
    var backgoundColor: Color = Color("BackgroundColor")
    
    
    var body: some View {
        
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(Font.system(size: 56))
                
                Text(text)
                    .font(.headline)
                // if the text is too long, handle multiple lines.
                    .multilineTextAlignment(.center)
            }
            .padding(28)
            .background(backgoundColor)
            .cornerRadius(12)
        }
 
    }
}

#Preview {
    TripAlert()
}
