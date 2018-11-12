//
//  UIColor-Extensions.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/9.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat , b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}
