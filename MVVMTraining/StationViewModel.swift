//
//  StationViewModel.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

class StationsListViewModel: StationsListViewProtocol {
    
    var stations = [Station]()
    var filteredStations = [Station]()
    var searchIsActive = false
    
    func fetchStations(completion: @escaping () -> Void) {
        self.stations.removeAll()
        
        DataManager.fetchStations { (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(stations):
                    self.stations.append(contentsOf: stations)
                case let .failure(error):
                    print("Error fetching stations. Error: \(error)")
                    self.stations.removeAll()
                }
                completion()
            }
        }
    }
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return searchIsActive ? self.filteredStations.count : self.stations.count
    }
    
    func stationNameToDisplay(for indexPath: IndexPath) -> String {
        let stationName = self.stations[indexPath.row].name
        var filteredStationName = ""
        if self.filteredStations.count > 0 {
            filteredStationName  = self.filteredStations[indexPath.row].name
        }
        return searchIsActive ? filteredStationName : stationName
    }
}



