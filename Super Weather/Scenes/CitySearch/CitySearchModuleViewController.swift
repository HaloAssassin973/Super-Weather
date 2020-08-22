//
//  CitySearchModuleViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchModuleDisplayLogic: class {
    
    ///описание
    func displayWeatherModule()
}

final class CitySearchModuleViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants: String {
        case cellId
        case title = "Cities List"
        case placeholder = "Search City"
    }
    
  
    //MARK: - Public properties
    
    var interactor: CitySearchModuleBusinessLogic!
    var router: CitySearchModuleRoutingLogic!
    
    
    //MARK: - Private properties
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [String] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        interactor.handleViewReady()
    }
}


// MARK: - SearchBar Delegate

extension CitySearchModuleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        cities.append(city)
        tableView.reloadData()
    }
}

// MARK: - Display logic

extension CitySearchModuleViewController: CitySearchModuleDisplayLogic {
    func displayWeatherModule() {
        
    }
}

//MARK: - TableView Protocols Implementation

extension CitySearchModuleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId.rawValue, for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss(animated: true, completion: {
            self.navigationController?.popViewController(animated: true)
            
            let weatherModuleVC = self.navigationController?.viewControllers.first as! WeatherModuleViewController
            weatherModuleVC.addedCities = self.cities
        })
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Configurations & Constraints

extension CitySearchModuleViewController {
    private func configurateSearchController() {
        searchController.searchBar.delegate = self
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
    
    private func configurateView() {
        view.assignBackground()
        
        configurateNavigation()
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
        
        configurateSearchController()
    }
}
