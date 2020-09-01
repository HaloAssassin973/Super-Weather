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
        let request = CitySearchModels.Fetch.Request(city: city)
        interactor.addCity(request)
        router.routeToWeatherModule()
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
        return 0
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
        })
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Configurations & Constraints

private extension CitySearchModuleViewController {
    func configurateSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.placeholder = Constants.placeholder.rawValue
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
    }
    
    func configurateNavigation() {
        navigationItem.title = Constants.title.rawValue
        navigationController?.navigationBar.accessibilityIdentifier = "City navigation"
    }
    
    func configurateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId.rawValue)
        tableView.confugurate(in: self)
        tableView.accessibilityIdentifier = "City table"
    }
    
    func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func configurateView() {
        view.assignBackground()
        
        configurateNavigation()
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
        
        configurateSearchController()
    }
}
