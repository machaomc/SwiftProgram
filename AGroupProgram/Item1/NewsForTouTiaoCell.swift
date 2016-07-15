//
//  NewsForTouTiaoCell.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit
import SDWebImage
class NewsForTouTiaoCell: UITableViewCell {
    let cellHeight:CGFloat = 80.0
    
    var image_News:UIImageView = UIImageView()
    var label_Title:UILabel = UILabel()
    var label_Content:UILabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        
        
        self.image_News.frame = CGRectMake(15, 10, 80, self.cellHeight - 20)
        self.image_News.backgroundColor = UIColor.clearColor()
        self.addSubview(self.image_News)
        
        self.label_Title.frame = CGRectMake(self.image_News.right+10, 10, APPScreenWidth - 15 - self.image_News.right - 10, 40)
        self.label_Title.numberOfLines = 0
        //self.label_Title.backgroundColor = UIColor.grayColor()
        self.label_Title.font = UIFont.systemFontOfSize(16.0)
        self.label_Title.textAlignment = NSTextAlignment.Left
        self.addSubview(self.label_Title)
        
        self.label_Content.frame = CGRectMake(self.image_News.right+10, self.label_Title.bottom + 6, APPScreenWidth - (self.image_News.right+10) - 15, self.cellHeight - self.label_Title.bottom - 6 - 10)
        self.label_Content.numberOfLines = 0
        self.label_Content.font = UIFont.systemFontOfSize(12.0)
        self.label_Content.textAlignment = NSTextAlignment.Left
        //self.label_Content.backgroundColor = UIColor.yellowColor()
        self.addSubview(self.label_Content)
    }
    
    func setDataWithModel(model:Model_TouTiao){
        self.label_Title.text = model.title as String
        self.label_Content.text = model.content as String
        self.image_News.sd_setImageWithURL(NSURL.init(string: model.imageUrl as String), placeholderImage: UIImage.init(named: "imageNews"))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getCellHeight() -> CGFloat{
        return 80.0
    }
}
