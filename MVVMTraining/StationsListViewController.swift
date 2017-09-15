//
//  StationsListViewController.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import UIKit

class StationsListViewController: UIViewController {
    
    let stationsListCellIdentifier = "StationsCell"
    let stationsListViewModel = StationsListViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("StationsListScreen_SearchStation", comment: "")
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshStationsList), for: .valueChanged)
        return refreshControl
    }()
    
    // Ask Ricardo if ther are any objections to using lazy here.
    lazy var stationsList: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(self.refreshControl)
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
    
    @objc private func refreshStationsList() {
        self.stationsListViewModel.fetchStations {
            self.stationsList.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - Table view data source methods.
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

// MARK: - Table view delegate source methods.
extension StationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        self.stationsListViewModel.stations.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
    }
}

// MARK: - Searchbar delegate methods.
extension StationsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.stationsListViewModel.searchIsActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentFor(searchText)
    }
    
    func filterContentFor(_ searchText: String) {
        let stations = self.stationsListViewModel.stations
        self.stationsListViewModel.filteredStations = stations.filter({ (station: Station) -> Bool in
            return station.name.lowercased().range(of: searchText.lowercased()) != nil
        })
        self.stationsList.reloadData()
    }
}
