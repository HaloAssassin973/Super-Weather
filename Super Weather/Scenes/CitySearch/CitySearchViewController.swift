//
//  CitySearchViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol CitySearchViewControllerInput {
    
}

protocol CitySearchViewControllerOutput {
    func fetchWeather(_ request: CitySearchScene.FetchWeather.Request)
}

class CitySearchViewController: UIViewController, CitySearchViewControllerInput {
  
    //MARK: - Properties
    var output: CitySearchViewControllerOutput?
    var router: CitySearchRouter?
    
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
    }
    
    // MARK: - Object lifecycle
    
    override func loadView() {
        super.loadView()
        CitySearchConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.assignbackground()
        configurateNavigation()
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
        configurateSearchController()
    }
    
    // MARK: - Requests
        
}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        let request = CitySearchScene.FetchWeather.Request(city: city)
        output?.fetchWeather(request)
    }
}

// MARK: - Display logic
extension CitySearchViewController: CitySearchPresenterOutput {
    func printWeather(_ viewModel: CitySearchScene.FetchWeather.ViewModel) {
        print(viewModel.weather)
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
        
//        dismiss(animated: true, completion: {
//            self.navigationController?.popViewController(animated: true)
//            let weatherVC = self.navigationController?.viewControllers.first as! WeatherModuleViewController
//            if !weatherVC.addedCities.contains(city) {
//                weatherVC.addedCities.append(city)
//            }
//        })
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Configurations & Constraints

extension CitySearchViewController {
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
}
