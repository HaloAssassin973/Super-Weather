//
//  NavigationExtension.swift
//  WeatherApp
//
//  Created by  Alexander on 25.07.2020.
//  Copyright © 2020  Alexander. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func configurate() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
