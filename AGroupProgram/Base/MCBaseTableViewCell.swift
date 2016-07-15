//
//  MCBaseTableViewCell.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCBaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.backgroundColor = APPMainBackGroudColor
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
