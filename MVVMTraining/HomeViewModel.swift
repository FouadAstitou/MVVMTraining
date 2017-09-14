//
//  HomeViewModel.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 13-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

class HomeViewModel: HomeViewProtocol {
    
    private let home: Home
    
    let titleText: String
    let descriptionText: String
    let isConnectedStatus: Bool
    
    required init(home: Home) {
        self.home = home
        
        self.titleText = home.title
        self.descriptionText = home.description
        self.isConnectedStatus = home.isConnected
    }
}
