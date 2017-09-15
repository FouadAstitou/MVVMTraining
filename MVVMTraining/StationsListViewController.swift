//
//  StationsListViewController.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import UIKit

class StationsListViewController: UIViewController {
    
    var stationsListViewModel = StationsListViewModel()
    var searchIsActive = false
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("StationsListScreen_SearchStation", comment: "")
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    var stationsList: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell") // Cell?? Origineel ;) probeer duidelijke namen te geven ipv cell. Wat voor een cell welke cell? StationsCell of Cell? Welke zie jij liever terug komen?
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        stationsListViewModel.fetchStations { 
            self.stationsList.reloadData()
        }
    }
    
    func setUpViews() {
        // To do: Need to be localized
        title = "Stations"
        navigationItem.titleView = self.searchBar
        view.backgroundColor = .white
        stationsList.dataSource = self
        //stationsList.delegate = self
        view.addSubview(stationsList)
    }
    
    func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        
        self.stationsList.translatesAutoresizingMaskIntoConstraints =  false
        self.stationsList.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.stationsList.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.stationsList.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.stationsList.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
    }
}

extension StationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationsListViewModel.numberOfItemsToDisplay(in: section, searchIsActive: self.searchIsActive)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) // He weer die Cell??? Misschien moet je iets verzinnen op een String waarde die je 2 keer gebruikt en echt geen typo in mag zitten.
        
        cell.textLabel?.text = self.stationsListViewModel.stationNameToDisplay(for: indexPath) // Hier gebruik je cell.textLabel?.text dit betekend als cell.textLabel niet bestaat dat de app klapt. We hebben het maandag over ? en ! gehad toen wist je ook wat je hieraan moest doen. Je weet het dus ook doen ;)
        
        return cell
    }
}

extension StationsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchIsActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let stations = self.stationsListViewModel.stations
        self.stationsListViewModel.filteredStations = stations.filter({ (station: Station) -> Bool in
            return station.name.contains(searchText.lowercased())
        })
        if !searchText.isEmptyAndContainsNoWhitespace() {
            self.searchIsActive = true
            self.stationsList.reloadData()
        } else {
            self.stationsListViewModel.filteredStations.removeAll()
            self.searchIsActive = false
            self.stationsList.reloadData()
        }
        
        print(stationsListViewModel.stations.count)
        print(stations.count)
        print(stationsListViewModel.filteredStations.count)

    }
}
