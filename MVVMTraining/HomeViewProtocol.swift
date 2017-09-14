//
//  HomeViewProtocol.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

protocol HomeViewProtocol {
    var titleText: String { get }
    var descriptionText: String { get }
    var isConnectedStatus: Bool { get }
    
    init(home: Home)
}
