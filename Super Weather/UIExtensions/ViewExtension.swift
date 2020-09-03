//
//  ViewExtension.swift
//  Super Weather
//
//  Created by Игорь Силаев on 11.08.2020.
//  Copyright (c) 2020 Игорь Силаев. All rights reserved.
//

import UIKit

extension UIView {
    
    func assignBackground() {
        let background = UIImage(named: "background")
        let imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        addSubview(imageView)
    }
}
