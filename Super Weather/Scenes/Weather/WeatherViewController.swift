//
//  WeatherViewController.swift
//  Super Weather
//
//  Created by Игорь Силаев on 30.06.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import UIKit

protocol WeatherViewInput: AnyObject {
    func updateView()
}

protocol WeatherViewOutput {
    func viewIsReady()
    func closePage()
}

final class WeatherViewController: UIViewController {

    //MARK: - Identifiers
    
    private enum Identifiers {
        static let mainViewController = "MainViewController"
        static let addButton = "Add button"
        static let tableView = "TableView"
    }
    
    //MARK: - Constants
       
       private enum Constants: String {
           case cellId
           case title = "Weather"
           case entityName = "City"
       }
       
    //MARK: - Properties
    var presenter: WeatherViewOutput?
    private let topStackView = UIStackView()
    private let bottomStackView = UIStackView()
    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let cityLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    var addedCities: [String] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
        configurateView()
        
        view.accessibilityIdentifier = Identifiers.mainViewController
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = Identifiers.addButton
        tableView.accessibilityIdentifier = Identifiers.tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

}

// MARK: - WeatherViewInput
extension WeatherViewController: WeatherViewInput {
    
    func updateView() {
        print("View updated")
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
            // Fallback on earlier versions
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
