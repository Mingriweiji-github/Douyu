//
//  HomeViewModel.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/15.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class HomeViewModel {
    //MARK: - 懒加载
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
    
}
extension HomeViewModel {
    func requestData() {
        //1.请求第一部分数据:推荐
        let param = ["time": Date.getCurrentTime(),"limit":4,"offset":"0"] as [String : Any]
        print(param)
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1542269597
        
        NetworkTool.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", param: param) { (result) in
            
            guard let resultDic = result as? [String: NSObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String: NSObject]] else {return}
            
            for dic in dataArray {
                let group = AnchorGroup(dict: dic)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups {
                print(group.tag_name)
            }
            
            
        }
        

        //2.请求第二部分:颜值
        
        //3.请求第三部分:游戏
        
    }
}
