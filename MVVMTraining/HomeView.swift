//
//  HomeView.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 13-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    private let homeViewModel = HomeViewModel(home: Home(title: "NSMindfulNS", description: "Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor Lorem Ipsum dolor", isConnected: false))
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var connectionStateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    var showStationsButton: UIButton = {
        let button = UIButton()
        // Needs localization
        button.setTitle("Show stations", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.titleLabel.text = self.homeViewModel.titleText
        self.descriptionLabel.text = self.homeViewModel.descriptionText
        self.connectionStateLabel.text = self.homeViewModel.isConnectedStatus ? "Connected" : "Connecting ..." // Localize
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(connectionStateLabel)
        //self.descriptionLabel.addSubview(showStationsButton)
    }
    
    func setUpConstraints() {
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -150).isActive = true
        
        self.titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        self.titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.connectionStateLabel.topAnchor, constant: -150).isActive = true
        
        self.connectionStateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.connectionStateLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor).isActive = true
        self.connectionStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.connectionStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.connectionStateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.connectionStateLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        self.connectionStateLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        
        //self.showStationsButton.translatesAutoresizingMaskIntoConstraints = false
        //self.showStationsButton.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: -8)
       // self.showStationsButton.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor, constant: -8)
        //self.showStationsButton.trailingAnchor.constraint(equalTo: self.descriptionLabel.trailingAnchor, constant: -8)
    }
}
