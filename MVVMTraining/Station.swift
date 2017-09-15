//
//  Station.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

class Station: StationProtocol {
    
    let code: String
    var name: String
    let radius: Int
    let latitude: Double
    let longitude: Double
    
    required init(code: String, name: String, radius: Int, latitude: Double, longitude: Double) {
        self.code = code
        self.name = name
        self.radius = radius
        self.latitude = latitude
        self.longitude = longitude
    }
}
