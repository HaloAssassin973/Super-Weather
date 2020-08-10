//
//  CitySearchViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 10.07.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

final class CitySearchViewController: UIViewController {
    
    //MARK: - Identifiers
    
    private enum Identifiers {
        static let cancelButton = "Cancel"
        static let searchTextField = "Search City"
    }
    
    //MARK: - Properties
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [String] = []
    private var filteredCities: [String] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: - Constants
    
    private enum Constants: String {
        case cellId
        case title = "Cities List"
        case placeholder = "Search City"
        case fileName = "Cities"
        case fileType = "txt"
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.assignbackground()
        configurateNavigation()
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
        configurateSearchController()
        
        
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = Identifiers.cancelButton
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.accessibilityIdentifier = Identifiers.searchTextField
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCities = cities.filter { (city) -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}


//MARK: - TableView Protocols Implementation

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId.rawValue, for: indexPath)
        if isFiltering {
            cell.textLabel!.text = filteredCities[indexPath.row]
            cell.accessibilityIdentifier = filteredCities[indexPath.row]
        } else {
            cell.textLabel!.text = cities[indexPath.row]
            cell.accessibilityIdentifier = cities[indexPath.row]
        }
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var city = ""
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        
        dismiss(animated: true, completion: {
            self.navigationController?.popViewController(animated: true)
            let weatherVC = self.navigationController?.viewControllers.first as! WeatherViewController
            if !weatherVC.addedCities.contains(city) {
                weatherVC.addedCities.append(city)
            }
        })
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - SearchController Protocols Implementation

extension CitySearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - Configurations & Constraints

extension CitySearchViewController {
    private func configurateSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.placeholder = Constants.placeholder.rawValue
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    private func configurateNavigation() {
        navigationItem.title = Constants.title.rawValue
        navigationController?.navigationBar.accessibilityIdentifier = "City navigation"
    }
    
    private func configurateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId.rawValue)
        tableView.confugurate(in: self)
        tableView.accessibilityIdentifier = "City table"
    }
    
    private func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

