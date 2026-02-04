//
//  SelectedStopCard.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//

import SwiftUI
import Combine

struct SelectedStopCard: View {
//expect arr of objects
    var SelectedStopObject: [metroobject]
    @State private var isButtonHidden = false



    
    
    var body: some View {
     
            //if the varialble value false will not draw the button if not it will draw it
        HStack{
            
            //for each need identfiable
            ForEach(SelectedStopObject) { item in
                
                if !isButtonHidden {
                    ZStack(alignment:.leading){
                        Button {
                            // Action: set the state to true when tapped
                            self.isButtonHidden = true
                        } label: {
                            Text(item.stopstationName)
                                .foregroundColor(.black)
                        }
                        .frame(width: 112,height: 48)
                        .background(Color("GreySubColor"))
                        .cornerRadius(16)
                        
                        Rectangle()
                            .foregroundColor(Color(item.metroLineColor))
                            .frame(width: 4,height: 28)
                            .cornerRadius(16)
                            .offset(x: 8,y: 0)
                        
                        
                    }//z
                }//if
            }//for
        }//h

    }

}

#Preview {
//expect arr of objects
    SelectedStopCard(
        SelectedStopObject: [obj1,obj4]
    )


}
//model
struct metroobject: Codable, Identifiable{
    var id = UUID()
    let metroLineColor:String
    let stopstationName:String
    
    
}
//objects
let obj1 = metroobject(metroLineColor: "BlueLine", stopstationName: "STC b")
let obj4 = metroobject(metroLineColor: "RedLine", stopstationName: "STC")
