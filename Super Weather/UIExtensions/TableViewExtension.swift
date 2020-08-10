//
//  TableViewExtension.swift
//  WeatherApp
//
//  Created by  Alexander on 25.07.2020.
//  Copyright © 2020  Alexander. All rights reserved.
//

import UIKit

extension UITableView {
    
    func confugurate(in controller: UIViewController) {
        self.tableFooterView = UIView()
        self.separatorStyle = .none
        self.backgroundColor = .clear
        self.dataSource = controller as? UITableViewDataSource
        self.delegate = controller as? UITableViewDelegate
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
