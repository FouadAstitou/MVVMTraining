//
//  StationsListViewController.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 14-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

enum LocalizedAlert: String {
    case alertTitle = "StationsListScreen_Alert_Title"
    case saveAction = "StationsListScreen_Save_Title"
    case cancelAction = "StationsListScreen_Cancel_Title"
}

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
    
    lazy var editCellNameTextField: UITextField = {
        let textField = UITextField()
        textField.sizeToFit()
        return textField
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
        self.stationsList.register(UITableViewCell.self, forCellReuseIdentifier: stationsListCellIdentifier)
        navigationItem.titleView = self.searchBar
        view.backgroundColor = .white
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
    
    // Very ugly, i know. Just for testing.
    func showAlerToEdit(_ text: String, at indexPath: IndexPath) {
        let alert = UIAlertController(title: LocalizedAlert.alertTitle.rawValue.localizedString(),
                                      message: "",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: LocalizedAlert.cancelAction.rawValue.localizedString(),
                                         style: .destructive) { (action) in }
        let saveAction = UIAlertAction(title: LocalizedAlert.saveAction.rawValue.localizedString(), style: .default) { (action) in
            guard let alertTextFields = alert.textFields,
                let firstTextField = alertTextFields.first,
                let stationName = firstTextField.text,
                !stationName.isEmptyAndContainsNoWhitespace() else {
                    return
            }
            self.stationsListViewModel.updateStation(name: stationName, at: indexPath)
            self.stationsList.reloadRows(at: [indexPath], with: .left)
        }
        
        alert.addTextField { (stationNameextField) in
            stationNameextField.becomeFirstResponder()
            stationNameextField.text = text
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationName = self.stationsListViewModel.stations[indexPath.row].name
        showAlerToEdit(stationName, at: indexPath)
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
