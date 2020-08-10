//
//  ViewExtension.swift
//  WeatherApp
//
//  Created by  Alexander on 25.07.2020.
//  Copyright © 2020  Alexander. All rights reserved.
//

import UIKit

extension UIView {
    
    func assignbackground() {
        let background = UIImage(named: "background")

        var imageView: UIImageView!
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        self.addSubview(imageView)
    }
}
