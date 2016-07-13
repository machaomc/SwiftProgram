//
//  QBTitleView.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

let TITLE_FONT_SIZE:CGFloat = 17.0

class QBTitleView: UIView {
    
    var button_title:UIButton!
    var label_title:UILabel!
    var title:NSString = ""{
        didSet {
            self.label_title.text = title as String
            self.label_title.numberOfLines = 0
            self.label_title.sizeToFit()
            
            
            var frame:CGRect = self.frame
            frame.size.width = self.label_title.bounds.width
            self.frame = frame
            self.label_title.frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            
            
            //self.update(title)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.button_title = UIButton.init(type: UIButtonType.Custom)
        self.button_title.frame = self.bounds
        self.button_title.addTarget(self, action: #selector(QBTitleView.touchDown(_:)), forControlEvents:.TouchDown)
        self.addSubview(self.button_title)
    
        self.label_title = UILabel.init(frame: self.bounds)
        self.label_title.font = UIFont.systemFontOfSize(TITLE_FONT_SIZE)
        self.label_title.textColor = UIColor.blackColor()
        self.label_title.backgroundColor = UIColor.clearColor()
        self.label_title.textAlignment = NSTextAlignment.Center
        self.label_title.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.button_title.addSubview(self.label_title)
        self.button_title.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.label_title.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
    }
    
    func touchDown(button:UIButton){
        print("按下")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(str:NSString){
        
        let attributes = [NSFontAttributeName: TITLE_FONT_SIZE]
        
        let titleSize:CGSize = str.boundingRectWithSize(CGSize(width: 300, height: 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        var frame:CGRect = self.frame
        frame.size.width = titleSize.width
        self.frame = frame
        
        self.label_title.frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
