//
//  MCItem2ViewController.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCItem2ViewController: MCBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var test = MCSystemHelper.isInstallAppWithURLScheme("imaster", urlName: "com.jzsec.imaster")
        print("getKeyFromConfig==\(test)")
        
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
