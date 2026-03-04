//
//  LocationPermissionTip.swift
//  MetroProject
//
//  Created by Dana on 12/09/1447 AH.
//

import SwiftUI
import TipKit

struct LocationPermissionTip: Tip {
    var title: Text {
        Text("Need Background Alerts?")
    }
    
    var message: Text? {
        Text("Make sure your location is set to 'Always' in your iPhone Settings so we can wake you up at your stop.")
    }
    
    var image: Image? {
        Image(systemName: "location.circle.fill")
        
    }
}
