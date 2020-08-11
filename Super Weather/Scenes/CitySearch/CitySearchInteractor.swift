//
//  CitySearchInteractor.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//


protocol CitySearchInteractorInput {
    
}

protocol CitySearchInteractorOutput {
    
}

protocol CitySearchDataSource {
    
}

protocol CitySearchDataDestination {
    
}

class CitySearchInteractor: CitySearchInteractorInput, CitySearchDataSource, CitySearchDataDestination {
    
    var output: CitySearchInteractorOutput?
    
    // MARK: - Business logic
    

}
