//
//  DataTool.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class DataTool: NSObject {

    
    /**
     加载阅读模块数据
     
     - parameter completionHandler: 返回数据的回调闭包
     */
    static func loadReadNewsData(completionHandler: [Model_TouTiao]? -> Void) {
        
        let urlStr = "http://c.3g.163.com/recommend/getSubDocPic"
        let parameter: [String : AnyObject] = [
            "from" : "yuedu",
            "size" : 20,
            "timestamp":NSDate.TimeIntervalSince1970()
        ]
        
        Alamofire.request(.GET, urlStr, parameters: parameter).responseJSON { (response) -> Void in
            guard response.result.error == nil else {
                print("load news error!")
                completionHandler(nil)
                return
            }
            let data = JSON(response.result.value!)
            let news = data["推荐"]
            var array: [Model_TouTiao] = []
            for (_, dict) in news {
                
                array.append(Model_TouTiao(json: dict))
            }
            
            completionHandler(array)
        }
    }

    
}

extension NSDate {
    class func TimeIntervalSince1970() -> NSTimeInterval{
        let nowTime = NSDate()
        return nowTime.timeIntervalSince1970
    }
}
