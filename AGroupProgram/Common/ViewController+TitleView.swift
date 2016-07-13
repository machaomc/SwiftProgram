//
//  ViewController+TitleView.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

extension MCBaseViewController{

    //设置title控件
    func setTitleView(){
        
        var titleView:QBTitleView
        titleView = QBTitleView.init(frame: CGRect.init(x: 0, y: 0, width: APPScreenWidth-80, height: 44))
        
        guard self.vcTitle != nil else {
           return
        }
        titleView.title = self.vcTitle!
        
        self.navigationItem.titleView = titleView
        self.titleView = titleView
        
    }

    func setVCTitle(title:NSString){
        self.titleView.title = title
        self.navigationItem.titleView = nil
        self.navigationItem.titleView = self.titleView
    }

}