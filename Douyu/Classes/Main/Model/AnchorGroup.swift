//
//  AnchorGroup.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    var room_list: [[String: AnyObject]]? {
        didSet {
            guard let roomList = room_list else {
                return
            }
            for dict in roomList {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var icon_name: String = "home_header_normal"
    
    //主播模型
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    

//    init(dict: [String: Any]) {
//        super.init()
//
//        setValuesForKeys(dict)
//    }
//
//    override func setValue(_ value: Any?, forKey key: String) {
//
//    }
}
