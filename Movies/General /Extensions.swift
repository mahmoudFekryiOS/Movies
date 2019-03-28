//
//  Extensions.swift
//  Movies
//
//  Created by mahmoud fekry on 3/28/19.
//  Copyright © 2019 mahmoud fekry. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var borderColor : UIColor?{
        get{return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!):nil}
        set{layer.borderColor = newValue?.cgColor}
    }
    @IBInspectable var borderWidth : CGFloat{
        
        get{return layer.borderWidth}
        set{layer.borderWidth = newValue}
    }
    @IBInspectable var CornerRaidus : CGFloat{
        
        get{return layer.cornerRadius}
        set{layer.cornerRadius = newValue}
    }
}
