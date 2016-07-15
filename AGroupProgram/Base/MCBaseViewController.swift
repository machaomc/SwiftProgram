//
//  MCBaseViewController.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCBaseViewController: UIViewController {
    
    var vcTitle:NSString?
    var titleView:QBTitleView = QBTitleView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let isHiddenTabBar:Bool = (self.navigationController?.tabBarController?.tabBar.hidden)!
        if isHiddenTabBar == false {
            self.view?.height = self.view.height - 49 - 64
        }
        
        // Do any additional setup after loading the view.
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

