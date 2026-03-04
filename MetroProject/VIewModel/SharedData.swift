//
//  SharedData.swift
//  MetroProject
//
//  Created by nouransalah on 23/08/1447 AH.
//

import Foundation
import Combine
//MARK: - 1. Shared Data Store
final class SharedData: ObservableObject {
    static let shared = SharedData()
    
    @Published var items: [MetroStation] = []
   
    private init() {}
}
