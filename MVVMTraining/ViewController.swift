//
//  ViewController.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 13-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let homeView = HomeView()
    
    var stationsButtonItem = UIBarButtonItem()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        // Todo: Needs localization
        title = "Home"
        view.backgroundColor = .white
        self.stationsButtonItem = UIBarButtonItem(title: "Stations", style: .plain, target: self, action: #selector(navigateToStationsListVC))
        self.navigationItem.rightBarButtonItem = self.stationsButtonItem
        view.addSubview(self.homeView)
    }
    
    private func setUpConstraints() {
        let margins = view.layoutMarginsGuide
        
        self.homeView.translatesAutoresizingMaskIntoConstraints = false
        self.homeView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        self.homeView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.homeView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.homeView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
    }
    
    func navigateToStationsListVC() { // als je je privates wil doortrekken moet deze ook private zijn.
        print("Detected Tap") // Eentje over print. Gebruik debugPrint ipv print. DebugPrint komen niet terug in release builds...prints wel.
        let stationsListVC = StationsListViewController() // Je hoeft hier niet een let te maken van de StationsListViewController deze kan je ook direct in de pushViewController aanmaken.
        self.navigationController?.pushViewController(stationsListVC, animated: true)
    }
}

