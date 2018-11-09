//
//  UIBarButtonItem-Extension.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/8.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
//    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
//        let button = UIButton()
//        button.frame = CGRect(origin: .zero, size: size)
//        button.setImage(UIImage(named: imageName), for: .normal)
//        button.setImage(UIImage(named: highImageName), for: .highlighted)
//        return UIBarButtonItem(customView: button)
//    }
    
    //便利构造函数  1,必须使用convenience 2.必须使用self
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        let button = UIButton()
        if size == .zero {
            button.sizeToFit()
        }else {
            button.frame = CGRect(origin: .zero, size: size)
        }
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: highImageName), for: .highlighted)
        self.init(customView: button)
    }
}
