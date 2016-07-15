//
//  MCBaseTableViewController.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCBaseTableViewController: MCBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var arrayData:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setTableView()
        
    }
    
    func setTableView(){
        self.tableView = UITableView.init(frame: self.view.bounds, style: self.setTableViewStyle())
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
    }
    
    func setTableViewStyle() ->UITableViewStyle{
       return .Plain
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default ,reuseIdentifier:initIdentifier)
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print(indexPath)
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
