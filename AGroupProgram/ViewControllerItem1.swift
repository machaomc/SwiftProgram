//
//  ViewControllerItem1.swift
//  AGroupProgram
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class ViewControllerItem1: UIViewController {

    @IBOutlet weak var button_sure: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.navigationController?.title = "修改";
        
        
        self.title = "修改";
        self.view.backgroundColor = UIColor.grayColor();
        
        let button_sure:UIButton = UIButton.init(type:UIButtonType.Custom);
        button_sure.frame = CGRectMake(15, 100, 300, 30)
        button_sure.backgroundColor = UIColor.redColor();
        
        
        
        button_sure.layer.cornerRadius = 5
        self.view.addSubview(button_sure)
        // Do any additional setup after loading the view.
        
        
        let arr:[Int]? = [3,5]
        //arr = nil
        print(arr)
        if let array = arr {
            print(array[1])
        }else
        {
            print("nil")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        print("确定");
        
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
