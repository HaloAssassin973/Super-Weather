//
//  TableViewExtension.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import UIKit

extension UITableView {
    
    func confugurate<T: UIViewController & UITableViewDelegate & UITableViewDataSource>(controller: T) {
        tableFooterView = UIView()
        separatorStyle = .none
        backgroundColor = .clear
        dataSource = controller
        delegate = controller
        translatesAutoresizingMaskIntoConstraints = false
    }
}
