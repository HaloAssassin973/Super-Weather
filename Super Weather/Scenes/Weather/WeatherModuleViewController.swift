//
//  WeatherModuleViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit
import CoreData

protocol WeatherModuleDisplayLogic: class {
    
    ///Отображение индикатора загрузки
    func displayActivityIndicator(isActive: Bool)
    
    ///Отображение ошибки
    func displayError(_ errorModel: WeatherModels.Show.ErrorModel)
    
    ///Отображение погоды из viewModel
    func displayWeather(_ viewModel: WeatherModels.Show.ViewModel)
    
    ///Отоброжение экрана с поиском города
    func displayCitySearch()
    
    ///Отображение городов в tableView
    func displayInitialData(_ viewModel: WeatherModels.FetchInitialData.ViewModel)
    
    ///Отображение без удаленных городов
    func displayWithoutDeleted(_ viewModel: WeatherModels.Delete.ViewModel)
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
    private let activityView = UIActivityIndicatorView()
    
    private var cities: [String] = []
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        interactor.handleViewReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        interactor.retrieveInitialData()
    }
}


// MARK: - Weather Module Display Logic

extension WeatherModuleViewController: WeatherModuleDisplayLogic {
    
    func displayActivityIndicator(isActive: Bool) {
        isActive ? activityView.startAnimating() : activityView.stopAnimating()
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
        iconImageView.image = viewModel.image
    }
    
    func displayCitySearch() {
        router.routeToCitySearch()
    }
    
    func displayInitialData(_ viewModel: WeatherModels.FetchInitialData.ViewModel) {
        cities = viewModel.cityNames
        tableView.reloadData()
    }
    
    func displayWithoutDeleted(_ viewModel: WeatherModels.Delete.ViewModel) {
        cities.remove(at: viewModel.index)
    }
}


//MARK: - TableView Protocols Implementation

extension WeatherModuleViewController: UITableViewDataSource, UITableViewDelegate,  NSFetchedResultsControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId.rawValue, for: indexPath)
        
        
        cell.textLabel?.text = cities[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
        let request = WeatherModels.Fetch.Request(city: city)
        interactor.fetchWeather(request)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let city = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
            let request = WeatherModels.Delete.Request(city: city, index: indexPath.row)
            interactor.deleteCity(request)
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
        
        view.addSubview(activityView)
        configurateActivityView()
        setActivityViewConstraints()
    }
    
    func configurateActivityView() {
        activityView.style = .whiteLarge
    }
    
    func setActivityViewConstraints() {
        activityView.center = self.view.center
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
        iconImageView.contentMode = .scaleAspectFit
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
                stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
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
