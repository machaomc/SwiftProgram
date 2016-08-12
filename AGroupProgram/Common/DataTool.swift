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
     加载今日头条模块数据
     
     - parameter completionHandler: 返回数据的回调闭包
     */
    static func loadReadNewsData(completionHandler: [Model_TouTiao]? -> Void) {
        
        let box:ChannelBox = ChannelBox.init()
        let urlStr = "http://c.m.163.com/nc/article/\(box[0].channelUrl)/0-20.html"
//        let parameter: [String : AnyObject] = [
//            "from" : "yuedu",
//            "size" : 20,
//            "timestamp":NSDate.TimeIntervalSince1970()
//        ]
        
        Alamofire.request(.GET, urlStr).responseJSON { (response) -> Void in
            guard response.result.error == nil else {
                print("load news error!")
                completionHandler(nil)
                return
            }
            let data = JSON(response.result.value!)
            let news = data[box[0].channelUrl.channelKey()]
            var array: [Model_TouTiao] = []
            for (_, dict) in news {
                array.append(Model_TouTiao(json: dict))
            }
            
            completionHandler(array)
        }
    }
}


extension String {
    
    func channelKey() -> String {
        let index = self.rangeOfString("/")
        let key = self.substringFromIndex(index!.endIndex)
        return key
    }
}

extension NSDate {
    class func TimeIntervalSince1970() -> NSTimeInterval{
        let nowTime = NSDate()
        return nowTime.timeIntervalSince1970
    }
}
