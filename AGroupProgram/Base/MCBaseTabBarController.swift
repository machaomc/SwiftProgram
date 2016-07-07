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
        var imgageName : NSString
        var selectedImageName:NSString
        
        for controller in arr {
            let index:Int = arr.indexOf(controller)!
            switch (index) {
            case 0:
                titleStr = "首页"
                imgageName = ""
                selectedImageName = ""
                break
            case 1:
                titleStr = "消息"
                imgageName = ""
                selectedImageName = ""
                break
            case 2:
                titleStr = "动态"
                imgageName = ""
                selectedImageName = ""
                break
            case 3:
                titleStr = "我的"
                imgageName = ""
                selectedImageName = ""
                break
            default:
                break
            }
            
            let nav:MCBaseNavigationController = MCBaseNavigationController.init(rootViewController: controller)
            nav.tabBarItem = UITabBarItem.init(title: titleStr as String, image: nil, selectedImage: nil)
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
