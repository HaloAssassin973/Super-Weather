//
//  WeatherModuleInteractorTest.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 30.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import XCTest
@testable import Super_Weather

final class WeatherModuleInteractorTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WeatherModuleInteractor!
    private var dataFetcherWorker: WeatherModuleDataFetcherSpy!
    private var presenter: WeatherModulePresentionLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let weatherInteractor = WeatherModuleInteractor()
        let weatherFetcherWorker = WeatherModuleDataFetcherSpy()
        let weatherPresenter = WeatherModulePresentionLogicSpy()
        
        weatherInteractor.dataFetcher = weatherFetcherWorker
        weatherInteractor.presenter = weatherPresenter
        
        sut = weatherInteractor
        dataFetcherWorker = weatherFetcherWorker
        presenter = weatherPresenter
    }
    
    override func tearDown() {
        sut = nil
        dataFetcherWorker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchWeather() {
        let request = WeatherModels.Fetch.Request(city: "London")
        
        sut.fetchWeather(request)
        
        XCTAssertTrue(dataFetcherWorker.isCalledFetchWeather, "Not started worker.fetchWeather(:)")
        XCTAssertTrue(presenter.isCalledPresentLoading, "Not started presenter.presentLoading")
    }
}
