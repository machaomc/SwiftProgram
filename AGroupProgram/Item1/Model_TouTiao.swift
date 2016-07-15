//
//  Model_TouTiao.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON
class Model_TouTiao: NSObject,NewsModelInitProtocol {
    
    var title:NSString
    var content:NSString
    var imageUrl:NSString

    required init(json: JSON) {
        
        title = json["title"].stringValue
        content = json["ptime"].stringValue
        imageUrl = json["img"].stringValue
        super.init()
        
    }
    
    
    
}

protocol NewsModelInitProtocol {
    init(json: JSON)
}
