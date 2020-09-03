//
//  WeatherViewControllerTests.swift
//  Super Weather UnitTests
//
//  Created by Игорь Силаев on 03.09.2020.
//  Copyright © 2020 Игорь Силаев. All rights reserved.
//

import XCTest
@testable import Super_Weather

final class WeatherViewControllerTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WeatherModuleViewController!
    private var interactor: WeatherBusinessLogicSpy!
    private var window: UIWindow!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let mainWindow = UIWindow()
        
        let weatherViewController = WeatherModuleViewController()

        window?.rootViewController = UINavigationController(rootViewController: weatherViewController)
        window?.makeKeyAndVisible()
        
        let interactor = WeatherBusinessLogicSpy()
        
        weatherViewController.interactor = interactor
        
        sut = weatherViewController
        window = mainWindow
        self.interactor = interactor
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        window = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    func testViewReady() {
        sut.viewDidLoad()
        
        XCTAssertTrue(interactor.isCalledHandleViewReady, "Not started interactor.handleViewReady")
    }
    
    func testRetrieveInitialData() {
        sut.viewWillAppear(true)
        
        XCTAssertTrue(interactor.isCalledRetrieveInitialData, "Not started interactor.retrieveInitialData")
        
    }
}
