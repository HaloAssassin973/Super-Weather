//
//  WeatherModuleViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit

protocol WeatherModuleDisplayLogic: class {
    
    ///описание
    func displayActivityIndicator(isActive: Bool)
    
    ///описание
    func displayError(_ errorModel: WeatherModels.Show.ErrorModel)
    
    ///описание
    func displayWeather(_ viewModel: WeatherModels.Show.ViewModel)
    
    ///описание
    func displayCitySearch()
}


final class WeatherModuleViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants: String {
        case cellId
        case title = "Weather"
        case entityName = "City"
    }
    
    
    //MARK: - Public properties
    
    var interactor: WeatherModuleBusinessLogic!
    var router: WeatherModuleRoutingLogic!
    
    
    //MARK: - Private properties
    
    private let topStackView = UIStackView()
    private let bottomStackView = UIStackView()
    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let cityLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    private var addedCities: [String] = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        interactor.handleViewReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}


// MARK: - Weather Module Display Logic

extension WeatherModuleViewController: WeatherModuleDisplayLogic {
    
    func displayActivityIndicator(isActive: Bool) {
        // display activity indicator
    }
    
    func displayError(_ errorModel: WeatherModels.Show.ErrorModel) {
        router.showErrorAlert(message: errorModel.message) { [weak self] success in
            //            self?.interactor....
        }
    }
    
    func displayWeather(_ viewModel: WeatherModels.Show.ViewModel) {
        cityLabel.text = viewModel.cityName
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        //        if let iconID = viewModel.iconID {
        //            iconImageView.addImage(with: iconID)
        //        }
    }
    
    func displayCitySearch() {
        router.routeToCitySearch()
    }
}


//MARK: - TableView Protocols Implementation

extension WeatherModuleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId.rawValue, for: indexPath)
        
        cell.textLabel?.text = addedCities[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            addedCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}


//MARK: - Configurations & Constraints

private extension WeatherModuleViewController {
    func configurateView() {
        
        view.assignBackground()
        
        configurateNavigation()
        
        view.addSubview(stackView)
        configurateStackView()
        setStackViewConstraints()
        
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
    }
    
    func configurateNavigation() {
        navigationController?.configurate()
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = Constants.title.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "Add button"
    }
    
    @objc func addTapped() {
        displayCitySearch()
    }
    
    func configurateTopStackView() {
        cityLabel.configurateCityLabel()
        descriptionLabel.configurateDescriptionLabel()
        topStackView.configuration()
        topStackView.addArrangedSubview(cityLabel)
        topStackView.addArrangedSubview(descriptionLabel)
    }
    
    func configurateBottomStackView() {
        temperatureLabel.configurateTemperatureLabel()
        iconImageView.configuration()
        bottomStackView.configuration()
        bottomStackView.addArrangedSubview(iconImageView)
        bottomStackView.addArrangedSubview(temperatureLabel)
    }
    
    func configurateStackView() {
        configurateTopStackView()
        configurateBottomStackView()
        stackView.configuration()
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
    }
    
    func setStackViewConstraints() {
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    func configurateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId.rawValue)
        tableView.confugurate(in: self)
    }
    
    func setTableViewConstraints() {
        let height: CGFloat = view.frame.height
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: height / 2)
        ])
    }
}
