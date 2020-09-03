//
//  WeatherPresenterTests.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 03.09.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import XCTest
@testable import Super_Weather



final class WeatherPresenterTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WeatherModulePresenter!
    private var view: WeatherDisplayLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let presenter = WeatherModulePresenter()
        let viewController = WeatherDisplayLogicSpy()
        
        presenter.view = viewController
        
        sut = presenter
        self.view = viewController
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testPresentLoading() {
        sut.presentLoading(isActive: true)
        
        XCTAssertTrue(view.isCalledDisplayActivityIndicator, "Not started view.displayActivityIndicator")
    }
    
    func testPresentWeatherWithError() {
        
        let response = WeatherModels.Fetch.Response(weather: nil, icon: nil, errorMessage: nil)
        
        sut.presentWeather(response)
        
        XCTAssertTrue(view.isCalledDisplayError, "Not started view.displayError")
    }
    
    func testPresentWeather() {
        let weather = WeatherAPI(coord: Coord(lon: 0, lat: 0), weather: [Weather(id: 0, main: "", weatherDescription: "", icon: "")], base: "", main: Main(temp: 0, pressure: 0, humidity: 0, tempMin: 0, tempMax: 0), visibility: 0, wind: Wind(speed: 0, deg: 0), clouds: Clouds(all: 0), dt: 0, sys: Sys(type: 0, id: 0, message: 0, country: "", sunrise: 0, sunset: 0), id: 0, name: "", cod: 0)
        
        let response = WeatherModels.Fetch.Response(weather: weather, icon: nil, errorMessage: nil)
        
        sut.presentWeather(response)
        
        XCTAssertTrue(view.isCalledDisplayWeather, "Not started view.displayWeather")
    }
    
    func testPresentCitySearch() {
        sut.presentCitySearch()
        
        XCTAssertTrue(view.isCalledDisplayCitySearch, "Not started view.displayCitySearch")
    }
    
    func testPresentWithoutDeletedCity() {
        let response = WeatherModels.Delete.Response(city: "London", index: 0)
        
        sut.presentWithoutDeletedCity(response)
        
        XCTAssertTrue(view.isCalledDisplayWithoutDeleted, "Not started view.displayWithoutDeleted")
    }
}

