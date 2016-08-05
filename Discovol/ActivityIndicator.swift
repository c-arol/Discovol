//
//  ActivityIndicator.swift
//  Discovol
//
//  Created by Carol Zhang on 8/5/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator: UIView {
    
    @IBOutlet weak var logo: UIImageView!
    
    override func awakeFromNib() {
        self.animate()
    }
    
    func animate() {
        logo.image = UIImage.animatedImageNamed("animatedLogo", duration: 0.4)
    }
    
    func stopAnimating() {
        logo.image = UIImage(named: "stillLogo")
    }
}