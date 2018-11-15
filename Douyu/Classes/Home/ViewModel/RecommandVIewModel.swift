//
//  RecommandVIewModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
class RecommandVIewModel: BaseViewModel {
    //lazy
//    lazy var cycleModels: [] = expression
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
}
extension RecommandVIewModel {
    func requestData(_ finishedCallback: @escaping() -> ()) {
        //1.请求第一部分数据:推荐
        //1.1定义参数
        let param = ["time": Date.getCurrentTime(),"limit":4,"offset":"0"] as [String : Any]
        print(param)
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1542269597
        //1.2.创建group
        let dGroup = DispatchGroup()
        //1.3请求推荐数据
        dGroup.enter()
        NetworkTool.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", param: param) { (result) in
            
            guard let resultDic = result as? [String: NSObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //获取主播数据
            for dic in dataArray {
                let anchor = AnchorModel(dict: dic)
                print(anchor.nickname)
                print("------")
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        
        //2.请求第二部分:颜值
        dGroup.enter()
        NetworkTool.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom") { (res) in
            guard let resultDic = res as? [String: NSObject] else {return}
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else { return }
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        //3.请求第三部分:游戏
        dGroup.enter()
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: param) {
            dGroup.leave()
        }
        
        //所有数据请求到以后,排序'
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
        
    }
    
    

}
