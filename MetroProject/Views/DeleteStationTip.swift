//
//  File.swift
//  MetroProject
//
//  Created by Asayl Hussien on 15/09/1447 AH.
//
import TipKit
import SwiftUI

struct DeleteStationTip: Tip {
    var title: Text {
        Text("Delete Station")
    }
    
    var message: Text? {
        Text("Tap on a station to remove it from the list")
    }
    
    var image: Image? {
        Image(systemName: "trash")
    }
}
