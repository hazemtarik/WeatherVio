//
//  UIViewX.swift
//  WeaterVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewX: UIView {

    @IBInspectable
    var CornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius  = CornerRadius
            self.layer.masksToBounds = CornerRadius > 0
        }
    }
    
    
}
