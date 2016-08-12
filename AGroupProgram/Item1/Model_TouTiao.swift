//
//  Model_TouTiao.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON
class Model_TouTiao: NewsChannelsHandle {
    
    

    required init(json: JSON) {
        
       
        super.init(json: json)
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

protocol NewsModelInitProtocol {
    init(json: JSON)
}
