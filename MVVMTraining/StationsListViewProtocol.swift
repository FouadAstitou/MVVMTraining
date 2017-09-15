//
//  StationViewProtocol.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

protocol StationsListViewProtocol {
    
    var stations: [Station] { get }
    var filteredStations: [Station] { get }
    var searchIsActive: Bool { get }
    
    func fetchStations(completion: @escaping () -> Void)
    func numberOfItemsToDisplay(in section: Int) -> Int
    func stationNameToDisplay(for indexPath: IndexPath) -> String
    func updateStation(name: String, at indexPath: IndexPath)
}
