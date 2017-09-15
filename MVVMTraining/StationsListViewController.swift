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
    let stationsListCellIdentifier = "StationsCell"
    //var searchIsActive = false
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("StationsListScreen_SearchStation", comment: "")
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    // Ask Ricardo if ther are any objections to using lazy here.
    lazy var stationsList: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
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
        navigationItem.titleView = self.searchBar
        view.backgroundColor = .white
        self.stationsList.register(UITableViewCell.self, forCellReuseIdentifier: stationsListCellIdentifier)

        //stationsList.dataSource = self
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
        return self.stationsListViewModel.numberOfItemsToDisplay(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: stationsListCellIdentifier, for: indexPath)
        guard let textLabel = cell.textLabel else {
            return cell
        }
        textLabel.text = self.stationsListViewModel.stationNameToDisplay(for: indexPath)
        return cell
    }
}

extension StationsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.stationsListViewModel.searchIsActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let stations = self.stationsListViewModel.stations
        self.stationsListViewModel.filteredStations = stations.filter({ (station: Station) -> Bool in
            return station.name.lowercased().range(of: searchText.lowercased()) != nil
        })
        if !searchText.isEmptyAndContainsNoWhitespace() {
            self.stationsListViewModel.searchIsActive = true
            self.stationsList.reloadData()
        } else {
            self.stationsListViewModel.filteredStations.removeAll()
            self.stationsListViewModel.searchIsActive = false
            self.stationsList.reloadData()
        }
    }
}
