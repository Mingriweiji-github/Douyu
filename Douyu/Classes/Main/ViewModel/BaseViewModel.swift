//
//  BaseViewModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}
extension BaseViewModel {
    func loadAnchorData(isGroupData:Bool, urlString: String, params: [String: Any]? = nil, finishedCallback: @escaping() -> ()) {
        NetworkTool.requestData(type: .get, urlString: urlString) { (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
            
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else {
                let group = AnchorGroup()
                
                for dic in dataArray {
                    group.anchors.append(AnchorModel(dict: dic))
                }
                
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
        }
    }
}
