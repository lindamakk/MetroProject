//
//  ChooseStopsTip.swift
//  MetroProject
//
//  Created by Linda on 03/03/2026.
//

import SwiftUI
import TipKit

struct ChooseStopsTip: Tip {

   var title: Text {
      Text("You Don’t Need to Select All Stops")
   }

   var message: Text? {
      Text("Only choose the stops where you actually want alerts. We'll notify you just for those stops.")
   }

   var image: Image? {
       Image(systemName: "bell.badge")
       
   }
}

