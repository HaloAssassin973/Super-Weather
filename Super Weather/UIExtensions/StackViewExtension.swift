//
//  StackViewExtension.swift
//  WeatherApp
//
//  Created by  Alexander on 21.07.2020.
//  Copyright © 2020  Alexander. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func configuration() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
