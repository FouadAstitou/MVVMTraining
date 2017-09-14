//
//  StationProtocol.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

protocol StationProtocol {
    var code: String { get }
    var name: String { get }
    var radius: Int { get }
    var latitude: Double { get }
    var longitude: Double { get }
    
    init(code: String, name: String, radius: Int, latitude: Double, longitude: Double)
}
