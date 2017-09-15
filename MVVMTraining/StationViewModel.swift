//
//  StationViewModel.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

class StationsListViewModel {
    
    var stations = [Station]() // Kleine opmerking hierover: Deze "var stations = [Station]()" is ook onderdeel van het protocol daardoor zou ik niet de extension maken die hieronder staat maar de extention verwijderen en de code hierin slepen.
    var filteredStations = [Station]()
}

extension StationsListViewModel: StationsListViewProtocol {
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
    
    func numberOfItemsToDisplay(in section: Int, searchIsActive: Bool) -> Int {
        if searchIsActive {
            return self.filteredStations.count
        } else {
            return self.stations.count
        }
    }
    
    func stationNameToDisplay(for indexPath: IndexPath) -> String {
        let station = self.stations[indexPath.row]
        let stationName = station.name
        return stationName
    }
}


