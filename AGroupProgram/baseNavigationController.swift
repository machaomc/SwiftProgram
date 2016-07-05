//
//  baseNavigationController.swift
//  AGroupProgram
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class baseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor(),
//            NSFontAttributeName: UIFont(name: "Heiti SC", size: 24.0)!], forState: UIControlState.Normal);
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor(),
                                                            NSFontAttributeName: UIFont(name: "Heiti SC", size: 18.0)!]
        
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
