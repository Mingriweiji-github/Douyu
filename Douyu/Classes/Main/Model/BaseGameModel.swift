//
//  BaseGameModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {
        
    }
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
