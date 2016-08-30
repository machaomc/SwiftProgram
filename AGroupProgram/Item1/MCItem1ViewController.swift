//
//  MCItem1Controller.swift
//  AGroupProgram
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MCItem1ViewController: MCBaseTableViewController {
    
    var tableHeaderView:HeaderImageView!
    var model_Header:Model_TouTiao!
    var readNewsArray: [Model_TouTiao] = [] {
        didSet {
            assert(tableView != nil)
            self.tableView!.reloadData()
        }
    }

    
    override func viewDidLoad() {
        self.vcTitle = "今日头条"
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.setTableViewHeader()
        self.tableView?.tableHeaderView = self.tableHeaderView
        //集成上拉与下拉刷新
        self.tableView!.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(MCItem1ViewController.requestInfo))
        //self.tableView!.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(MCItem1ViewController.requestMoreInfo))
        
        self.tableView!.mj_header.beginRefreshing()
    }
    
    func setTableViewHeader(){
        self.tableHeaderView = HeaderImageView.init(frame: CGRectMake(0, 0, APPScreenWidth, 180))
        self.tableHeaderView.backgroundColor = UIColor.grayColor()
        
    }
    
    /**
     下拉刷新回调方法
     */
    func requestInfo() {
        DataTool.loadReadNewsData { response -> Void in
            self.readNewsArray.removeAll()
            self.tableView!.mj_header.endRefreshing()
            guard var modelArray = response else {
                return
            }
            self.model_Header = modelArray.first
            
            self.tableHeaderView.model = self.model_Header
            self.tableHeaderView.showImageWithModel()
            
            modelArray.removeFirst()
            self.readNewsArray = modelArray +  self.readNewsArray
        }
    }
    /**
     上拉刷新回调方法
     */
    func requestMoreInfo() {
        // 其实上拉加载数据的请求有点不同，这里偷懒就不区分了^_^
        DataTool.loadReadNewsData { response -> Void in
            self.tableView!.mj_footer.endRefreshing()
            guard let modelArray = response else {
                return
            }
            self.readNewsArray += modelArray
        }
    }
    
    
    //UITableViewDelegate
    override func setTableViewStyle() ->UITableViewStyle{
        return .Plain
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.readNewsArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NewsForTouTiaoCell.getCellHeight()
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "NewsForTouTiaoCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? NewsForTouTiaoCell
        if cell == nil {
            cell = NewsForTouTiaoCell(style: UITableViewCellStyle.Default ,reuseIdentifier:initIdentifier)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        cell?.setDataWithModel(self.readNewsArray[indexPath.row])
    
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
