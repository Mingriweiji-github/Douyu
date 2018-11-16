//
//  CycleModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/16.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title: String?
    var pic_url: String?
    var anchor: AnchorModel?
    
    var room: [String: NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
