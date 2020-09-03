//
//  WeatherInteractorTests.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 30.08.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import XCTest
@testable import Super_Weather

final class WeatherInteractorTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WeatherModuleInteractor!
    private var dataFetcherWorker: WeatherDataFetcherSpy!
    private var presenter: WeatherPresentionLogicSpy!
    private var coreDataWorker: WeatherCoreDataWorkerSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let weatherInteractor = WeatherModuleInteractor()
        let weatherFetcherWorker = WeatherDataFetcherSpy()
        let weatherPresenter = WeatherPresentionLogicSpy()
        let weatherCoreDataWorker = WeatherCoreDataWorkerSpy()
        
        weatherInteractor.dataFetcher = weatherFetcherWorker
        weatherInteractor.presenter = weatherPresenter
        weatherInteractor.coreDataWorker = weatherCoreDataWorker
        
        sut = weatherInteractor
        dataFetcherWorker = weatherFetcherWorker
        presenter = weatherPresenter
        coreDataWorker = weatherCoreDataWorker
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

    func testHandleViewReady() {
        sut.handleViewReady()
        
        XCTAssertTrue(presenter.isCalledPresentLoading, "Not started presenter.presentLoading")
    }
    

    func testRetrieveInitialData() {
        sut.retrieveInitialData()
        
        XCTAssertTrue(coreDataWorker.isCalledRetrieveCityEntitiesFetchController, "Not started coreDataWorker.retrieveCityEntities")
        XCTAssertTrue(presenter.isCalledPresentInitialData, "Not started presenter.presentInitialData")
    }
    

    func testDeleteCity() {
        let request = WeatherModels.Delete.Request(city: "London", index: 0)
        
        sut.deleteCity(request)
        
        XCTAssertTrue(presenter.isCalledPresentWithoutDeletedCity, "Not started presenter.presentWithoutDeletedCity")
        XCTAssertTrue(coreDataWorker.isCalledDeleteCityEntity, "Not started coreDataWorker.deleteCityEntity")
    }
}
