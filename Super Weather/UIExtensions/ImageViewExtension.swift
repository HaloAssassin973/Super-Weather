//
//  ImageViewExtension.swift
//  WeatherApp
//
//  Created by  Alexander on 24.07.2020.
//  Copyright © 2020  Alexander. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func configuration() {
        self.image = #imageLiteral(resourceName: "10d")
        self.contentMode = .scaleAspectFit
        size()
    }
    
    private func size() {
        
        let size = UIScreen.main.bounds.width / 4.5
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: size),
            self.widthAnchor.constraint(equalToConstant: size)
        ])
    }
}
