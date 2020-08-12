//
//  WeatherViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


import UIKit
import CoreLocation

protocol WeatherViewControllerInput {

}

protocol WeatherViewControllerOutput {
    func fetchWeather(_ viewModel: WeatherScene.FetchWeather.Request)
}

class WeatherViewController: UIViewController {
    
    //MARK: - Constants
    private enum Constants: String {
        case cellId
        case title = "Weather"
        case entityName = "City"
    }
    
    
    //MARK: - Properties
    var output: WeatherViewControllerOutput?
    var router: WeatherRouter?
    
    private let topStackView = UIStackView()
    private let bottomStackView = UIStackView()
    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let cityLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    var addedCities: [String] = []
    
    
    
    // MARK: - Object lifecycle
    
    override func loadView() {
        super.loadView()
        WeatherConfigurator.sharedInstance.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        loadWeatherInfromation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Requests
    private func loadWeatherInfromation() {
        let request = WeatherScene.FetchWeather.Request(city: "Moscow")
        output?.fetchWeather(request)
    }
    
    // MARK: - Display logic
    
}

extension WeatherViewController: WeatherPresenterOutput {
    func printWeather(_ viewModel: WeatherScene.FetchWeather.ViewModel) {
        print(viewModel)
    }
    
    
}

//MARK: - TableView Protocols Implementation
extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        let city = addedCities[indexPath.row]
        
        //        dataFetcher.fetchWeather(searchTerm: city){ (data)  in
        //            if let data = data {
        //                self.cityLabel.text = data.name
        //                self.temperatureLabel.text = String(format: "%.0f", data.main.tempCelsius) + "°"
        //                self.descriptionLabel.text = data.weather.first?.weatherDescription
        //                self.iconImageView.addImage(with: data.weather.first!.icon)
        //            }
        //        }
        
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
extension WeatherViewController {
    private func configurateView() {
        
        view.assignbackground()
        
        configurateNavigation()
        
        view.addSubview(stackView)
        configurateStackView()
        setStackViewConstraints()
        
        view.addSubview(tableView)
        configurateTableView()
        setTableViewConstraints()
    }
    
    private func configurateNavigation() {
        navigationController?.configurate()
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = Constants.title.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "Add button"
    }
    
    @objc private func addTapped() {
        self.navigationController?.pushViewController(CitySearchViewController(),
                                                      animated: true)
    }
    
    private func configurateTopStackView() {
        cityLabel.configurateCityLabel()
        descriptionLabel.configurateDescriptionLabel()
        topStackView.configuration()
        topStackView.addArrangedSubview(cityLabel)
        topStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configurateBottomStackView() {
        temperatureLabel.configurateTemperatureLabel()
        //        iconImageView.configuration()
        bottomStackView.configuration()
        bottomStackView.addArrangedSubview(iconImageView)
        bottomStackView.addArrangedSubview(temperatureLabel)
    }
    
    private func configurateStackView() {
        configurateTopStackView()
        configurateBottomStackView()
        stackView.configuration()
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)
    }
    
    private func setStackViewConstraints() {
        
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
    
    private func configurateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId.rawValue)
        tableView.confugurate(in: self)
    }
    
    private func setTableViewConstraints() {
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
