//
//  DataManager.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

enum StationsResult {
    case success([Station])
    case failure(Error)
}

enum APIError: Error {
    case invalidJSONData
    case errorProcessingStations
}

struct DataManager {
    
    fileprivate static let baseURLString = "http://softchamp.nl/NS/TripData.json"
    
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    static func fetchStations(completion: @escaping (StationsResult) -> Void) {
        
        guard let url = URL(string: self.baseURLString) else {
            return
        }
        let request = URLRequest(url: url )
        let task = self.session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            if let data = data {
                print("DATA: \(data)") // Eentje over print. Gebruik debugPrint ipv print. DebugPrint komen niet terug in release builds...prints wel.
                let result = self.processStations(data: data, error: error as NSError?)
                // Use Main Que??
                completion(result)
            }
        })
        task.resume()
    }
    
    static func processStations(data: Data?, error: NSError?) -> StationsResult {
        guard let jsonData = data else {
            print("Error processing stations: \(error)") // Eentje over print. Gebruik debugPrint ipv print. DebugPrint komen niet terug in release builds...prints wel.
            return .failure(APIError.errorProcessingStations)
        }
        return self.stationsFromJSONData(jsonData)
    }
    
    static func stationsFromJSONData(_ data: Data) -> StationsResult {
        // Vind de onderstaande code erg netjes! ondanks me gezeik over die prints
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let
                jsonDictionary = jsonObject as? [AnyHashable: Any],
                let tripInfo = jsonDictionary["tripInfo"] as? [String: AnyObject],
                let stops = tripInfo["stops"] as? [[String: AnyObject]] else {
                    
                    return .failure(APIError.invalidJSONData)
            }
            var stations = [Station]()
            for stop in stops {
                guard let stationObject = stop["station"] as? [String: AnyObject],
                let code = stationObject["code"] as? String,
                let name = stationObject["name"] as? String,
                let radius = stationObject["radius"] as? Int,
                let latitude = stationObject["lat"] as? Double,
                let longintude = stationObject["lng"] as? Double else {
                    return .failure(APIError.invalidJSONData)
                }
                let station = Station(code: code, name: name, radius: radius, latitude: latitude, longitude: longintude)
                print("Station: \(station.name)")// Eentje over print. Gebruik debugPrint ipv print. DebugPrint komen niet terug in release builds...prints wel.
                stations.append(station)
            }
            return .success(stations)
        }
        catch let error {
            print(error)// Eentje over print. Gebruik debugPrint ipv print. DebugPrint komen niet terug in release builds...prints wel.
        }
        return .success([])
    }
}
