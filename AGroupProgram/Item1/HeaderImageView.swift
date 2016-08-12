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
         self.imageScrollView.removeFromSuperview()
         self.imageScrollView.frame = self.bounds

//        for var index = 0; index < self.model.ads?.count; index+=1 {
//            print("index is \(index)")
//            var indexFlo:Float = Float(index) * (APPScreenWidth as Int)
//            //var imageView:UIImageView = UIImageView.init(frame: CGRectMake(((index as Float)*APPScreenWidth) as Float, 0, APPScreenWidth, 100))
//            
//        }
        
        for i in 0..<self.model.ads!.count {
            print("index is \(i)")
            //var imageView:UIImageView = UIImageView.init(frame: CGRectMake(i as Int, 0, APPScreenWidth, 100))
            
        }
    }
    


}
