//
//  HomeModel.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 13-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

class Home: HomeProtocol {
    let title: String
    let description: String
    let isConnected: Bool
    
    required init(title: String, description: String, isConnected: Bool) {
        self.title = title
        self.description = description
        self.isConnected = isConnected
    }
}



