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
        title = NSLocalizedString("HomeScreen_Home", comment: "")
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
    
    @objc private func navigateToStationsListVC() { 
        self.navigationController?.pushViewController(StationsListViewController(), animated: true)
    }
}

