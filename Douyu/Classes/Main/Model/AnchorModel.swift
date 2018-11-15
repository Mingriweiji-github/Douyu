//
//  AnchorModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //    var room_id:String = ""
    var room_id: Int = 0
    var vertical_src:String = ""
    var room_name: String = ""
    //isVertical 0:pc直播 1:手机直播
    var nickname: String = ""
    var isVertical: Int = 0
    var online: Int = 0
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
