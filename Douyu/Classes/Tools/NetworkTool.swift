//
//  NetworkTool.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/14.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}
class NetworkTool {
    class func requestData(type: MethodType,urlString: String, param: [String: Any]? = nil, finishCallback: @escaping (_ result: Any) -> ()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: param).responseJSON { (res) in
            
            guard let result = res.result.value else {
                print(res.result.error)
                return
            }
            
            finishCallback(result)
        }
        
    }
}
