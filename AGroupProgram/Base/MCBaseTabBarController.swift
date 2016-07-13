//
//  MCBaseTabBarController.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = self.tabBarControllers()
        // Do any additional setup after loading the view.
    }

    func tabBarControllers() -> [MCBaseNavigationController] {
        let arr:[MCBaseViewController] = [MCItem1ViewController(),MCItem2ViewController(),MCItem3ViewController(),MCItem4ViewController()]
        
        var arrayController : [MCBaseNavigationController] = []
        var titleStr : NSString = ""
        var imgageName : NSString = ""
        var selectedImageName:NSString = ""
        
        for controller in arr {
            let index:Int = arr.indexOf(controller)!
            switch (index) {
            case 0:
                titleStr = "新闻"
                imgageName = "tabbar_icon_news_normal"
                selectedImageName = "tabbar_icon_news_highlight"
                break
            case 1:
                titleStr = "阅读"
                imgageName = "tabbar_icon_reader_normal"
                selectedImageName = "tabbar_icon_reader_highlight"
                break
            case 2:
                titleStr = "视听"
                imgageName = "tabbar_icon_media_normal"
                selectedImageName = "tabbar_icon_media_highlight"
                break
            case 3:
                titleStr = "我的"
                imgageName = "tabbar_icon_me_normal"
                selectedImageName = "tabbar_icon_me_highlight"
                break
            default:
                break
            }
            
            let nav:MCBaseNavigationController = MCBaseNavigationController.init(rootViewController: controller)
            nav.tabBarItem = UITabBarItem.init(title: titleStr as String, image: UIImage.init(named: imgageName as String), selectedImage: UIImage.init(named: selectedImageName as String))
            
            nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.grayColor()], forState: UIControlState.Normal)
            nav.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.redColor()], forState: UIControlState.Selected)
            arrayController.append(nav)
            
            
        }
        
        return arrayController
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
