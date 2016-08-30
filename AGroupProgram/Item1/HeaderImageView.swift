//
//  HeaderImageView.swift
//  AGroupProgram
//
//  Created by Mac on 16/8/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class HeaderImageView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageScrollView:UIScrollView!
    var model:Model_TouTiao!
    func showImageWithModel(){
        
        
        if let iahave = self.imageScrollView
        {
            self.imageScrollView.removeFromSuperview()
        }
        
        self.imageScrollView = UIScrollView.init(frame: self.bounds)
        self.imageScrollView.contentSize = CGSizeMake(self.bounds.width*4, 180)
        self.imageScrollView.pagingEnabled = true
        self.addSubview(self.imageScrollView)
        var count:CGFloat = 0;
        for var index = 0; index < self.model.ads?.count; index+=1 {
            print("index is \(index)")
            //var indexFlo:Float = Float(index) * (APPScreenWidth as Int)
            var imageView:UIImageView = UIImageView.init(frame: CGRectMake(count*self.bounds.width, 0, APPScreenWidth, 180))
            
            var ads:Ads = self.model.ads![index]
            imageView.sd_setImageWithURL(NSURL.init(string: ads.imgsrc))
            self.imageScrollView.addSubview(imageView)
            count++
        }
        
    }
    


}
