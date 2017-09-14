//
//  HomeProtocol.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

protocol HomeProtocol {
    var title: String { get }
    var description: String { get }
    var isConnected: Bool { get }
    
    init(title: String, description: String, isConnected: Bool)
}
