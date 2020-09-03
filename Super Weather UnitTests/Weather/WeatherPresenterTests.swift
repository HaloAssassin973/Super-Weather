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
    private var viewController: WeatherDisplayLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let presenter = WeatherModulePresenter()
        let viewController = WeatherDisplayLogicSpy()
        
        presenter.view = viewController
        
        sut = presenter
        self.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods

}
