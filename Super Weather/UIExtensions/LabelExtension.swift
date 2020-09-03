//
//  LabelExtension.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import UIKit

extension UILabel {
    
    private enum Constant {
        static let cityTitle = "Current city"
        static let temperatureTitle = "-°"
        static let descriptionTitle = "Description"
        
        static let cityFont = UIFont.systemFont(ofSize: 25,
                                                weight: .regular)
        static let temperatureFont = UIFont.systemFont(ofSize: 150,
                                                       weight: .ultraLight)
        static let descriptionFont = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    func configurateCityLabel(with text: String = Constant.cityTitle, and font: UIFont = Constant.cityFont) {
        configurateLabel(with: text, and: font)
    }
    
    func configurateTemperatureLabel(with text: String = Constant.temperatureTitle, and font: UIFont = Constant.temperatureFont) {
        configurateLabel(with: text, and: font)
    }
    
    func configurateDescriptionLabel(with text: String = Constant.descriptionTitle, and font: UIFont = Constant.descriptionFont) {
        configurateLabel(with: text, and: font)
        textColor = .lightGray
    }
    
    private func configurateLabel(with text: String, and font: UIFont) {
        self.text = text
        self.font = font
        textColor = .white
        textAlignment = .center
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = true
    }
}
