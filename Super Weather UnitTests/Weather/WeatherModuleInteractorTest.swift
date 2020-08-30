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
    private var worker: WeatherModuleBusinessLogicSpy!
    private var presenter: WeatherModulePresentionLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let weatherInteractor = WeatherModuleInteractor()
        let weatherWorker = WeatherModuleBusinessLogicSpy()
        let weatherPresenter = WeatherModulePresentionLogicSpy()
        
        weatherInteractor.dataFetcher = weatherWorker
        weatherInteractor.presenter = weatherPresenter
        
        sut = weatherInteractor
        worker = weatherWorker
        presenter = weatherPresenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchWeather() {
        let request = WeatherModels.Fetch.Request(city: "London")
        
        sut.fetchWeather(request)
        
        XCTAssertTrue(worker.isCalledFetchWeather, "Not started worker.fetchWeather(:)")
        XCTAssertTrue(presenter.isCalledPresentLoading, "Not started presenter.presentLoading")
    }
}
