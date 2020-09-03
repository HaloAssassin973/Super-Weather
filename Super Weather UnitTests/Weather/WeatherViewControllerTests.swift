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
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Weather", bundle: bundle)
        
        let viewController = storyboard.instantiateViewController(
            identifier: "WeatherModuleViewController") as? WeatherModuleViewController
        let interactor = WeatherBusinessLogicSpy()
        
        viewController?.interactor = interactor
        
        sut = viewController
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

}
