//
//  FarmDetailViewController.swift
//  AWPigSearch
//
//  Created by 数据库实验室 on 15/8/16.
//  Copyright (c) 2015年 PonyMuch. All rights reserved.
//

import UIKit

class FarmDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, BMKLocationServiceDelegate{
    
    //是否收藏了
    var is_collected = false
    
    ///猪场名称
    var z_org_nm = ""
    
    ///猪场id_key
    var z_org_id = ""
    
    ///猪场位置经度
    var z_longitude = String()
    
    ///猪场位置纬度
    var z_latitude = String()
    
    ///用户位置信息
    var user_location_coor: CLLocationCoordinate2D?
    
    var z_sale_piglet = ""
    var z_sow_num = ""
    var z_sale_pig = ""
    var z_sale_sow = ""
    
    ///百度定位
    var baidu_user_location: BMKLocationService!
    
    ///完成定位标志
    var didUpdateLocation = false
    
    @IBOutlet var table_view: UITableView!

    
    //MARK: View Controller
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //设置BarItem
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "猪场监控", style: UIBarButtonItemStyle.Plain, target: self, action: "farm_camera:")
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "video_camera"), style: UIBarButtonItemStyle.Plain, target: self, action: "farm_camera:")
        
        baidu_user_location = BMKLocationService()
        
        baidu_user_location.startUserLocationService()
        
        self.title = z_org_nm
        
        self.check_is_collected()
        
        
    }
    
    
    ///查看摄像头
    func farm_camera(sender: AnyObject) {
        
        /*
        let view = UIStoryboard(name: "FattenManageView", bundle: nil).instantiateViewControllerWithIdentifier("camera_list_view") as! CameraListViewController
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
        */
        
    }
    
    override func viewWillAppear(animated: Bool) {
        baidu_user_location.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        baidu_user_location.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    //MARK: Baidu Location Servce
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        
        self.user_location_coor = userLocation.location.coordinate
        
        didUpdateLocation = true
        
        baidu_user_location.stopUserLocationService()
    }
    
    //MARK: - Table View Delegate & Datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 4
        }
        else if section == 1{

            return 3
        }
        else
        {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //待销售仔猪 母猪存栏数 待销售肥猪 待销售种猪
        if (indexPath.section == 0)
        {
            var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("count_cell") as UITableViewCell?
            
            if cell == nil
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "count_cell")
            }
            
            if indexPath.row == 0
            {
                let label = cell?.viewWithTag(1) as! UILabel
                
                label.text = "待销售仔猪 : " + self.z_sale_piglet
                
                return cell!
            }
            
            else if indexPath.row == 1
            {
                let label = cell?.viewWithTag(1) as! UILabel
                
                label.text = "母猪存栏数 : " + self.z_sow_num
                
                return cell!
            }
            else if indexPath.row == 2
            {
                let label = cell?.viewWithTag(1) as! UILabel
                
                label.text = "待销售肥猪 : " + self.z_sale_pig
                
                return cell!
            }
            else
            {
                let label = cell?.viewWithTag(1) as! UILabel
                
                label.text = "待销售种猪 : " + self.z_sale_sow
                
                return cell!
            }
            
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("contact_cell") as UITableViewCell?
                
                if cell == nil
                {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "contact_cell")
                }
                
                return cell!
            }
            else if indexPath.row == 2
            {
                var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("collect_cell") as UITableViewCell?
                
                if cell == nil
                {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "collect_cell")
                }
                
                if self.is_collected == true
                {
                    cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                
                return cell!
            }
            else{
                var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("navigation_cell") as UITableViewCell?
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "navigation_cell")
                }
                return cell!
            }
        }
        else{
            
            var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("more_info_cell") as UITableViewCell?
            
            if cell == nil
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "more_info_cell")
            }
            
            return cell!
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "猪只详情"
        }
        else if section == 1 {
            return "咨询、导航、收藏"
        }
        else {
            return "选购信息"
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 40.0
        }
        else if indexPath.section == 1
        {
            return 45.0
        }
        else{
            return 50.0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 35
        }
        else
        {
            return 25
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if (indexPath.section == 1 && indexPath.row == 0) {
            
            if UESR_DID_LOG_IN_CHAT == true {
                
                let conversationVC = RCConversationViewController()
                conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE
                
                
                let user_defaults = NSUserDefaults.standardUserDefaults()
                user_defaults.setObject(self.z_org_nm, forKey: "\(self.z_org_id)")
                user_defaults.synchronize()
                
                conversationVC.targetId = self.z_org_id
                conversationVC.userName = self.z_org_nm
                conversationVC.title = "聊天"
                conversationVC.displayUserNameInCell = true
                conversationVC.enableNewComingMessageIcon = true
                conversationVC.enableUnreadMessageIcon = true
                
                conversationVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(conversationVC, animated: true)
            }
            else{
                SVProgressHUD.showInfoWithStatus("当前未在线,请前往消息模块更新", maskType: SVProgressHUDMaskType.Gradient)
            }
            /*HttpRequest.http_request_getUserByZc(session_key: constant_session_key, zc_id: self.z_org_id, result_block: { (json_result) -> Void in
                //print(json_result)
                if json_result != nil {
                    
                    let alert_control = UIAlertController(title: self.z_org_nm, message: "请选择对应的联系人", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    
                    let json_array = json_result["info"].array!
                    
                    if json_array.count > 0 {
                        
                        var alert_action: UIAlertAction!
                        
                        for json in json_array {
                            
                            alert_action = UIAlertAction(title: json["z_staff_nm"].stringValue, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                                
                                let conversationVC = RCConversationViewController()
                                
                                conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE
                                print("联系人")
                                print(json["z_staff_nm"].stringValue)
                                
                                conversationVC.targetId = json["z_staff_nm"].stringValue
                                conversationVC.userName = json["z_staff_nm"].stringValue
                                conversationVC.title = json["z_staff_nm"].stringValue
                                conversationVC.displayUserNameInCell = true
                                conversationVC.enableNewComingMessageIcon = true
                                conversationVC.enableUnreadMessageIcon = true
                                
                                conversationVC.hidesBottomBarWhenPushed = true
                                
                                self.navigationController?.pushViewController(conversationVC, animated: true)
                            })
                            
                            alert_control.addAction(alert_action)
                        }
                    }
                    
                    let alert_cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
                    
                    alert_control.addAction(alert_cancel)
                    
                    self.presentViewController(alert_control, animated: true, completion: nil)
                }
                else{
                    SVProgressHUD.showInfoWithStatus("服务器错误,稍后再试", maskType: SVProgressHUDMaskType.Gradient)
                }
            })
            */

        }
        if (indexPath.section == 1 && indexPath.row == 2) {
            if is_collected == false {
                self.collect_cell_clicked()
            }
        }
        if (indexPath.section == 1 && indexPath.row == 1 ) {
            
            if didUpdateLocation {
                openNativeNavi()
            }
            else{
                SVProgressHUD.showInfoWithStatus("正在为导航做定位准备,稍后", maskType: SVProgressHUDMaskType.Gradient)
            }
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
           let view = self.storyboard?.instantiateViewControllerWithIdentifier("farm_pig_buy_view") as! FarmPigBuyViewController
            
            view.z_org_nm = self.z_org_nm
            view.z_org_id = self.z_org_id
            
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    ///调用百度地图导航
    func openNativeNavi(){
   
        if self.z_latitude == "" || self.z_longitude == "" {
            SVProgressHUD.showInfoWithStatus("猪场位置数据缺失,无法导航", maskType: SVProgressHUDMaskType.Gradient)
            return
        }
        
        let para = BMKNaviPara()
        
        let start = BMKPlanNode()
        start.pt = self.user_location_coor!
        start.name = "我的位置"
        
        
        let end = BMKPlanNode()
        let end_coor = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.z_latitude)!, longitude: CLLocationDegrees(self.z_longitude)!)
        end.pt = end_coor
        end.name = self.z_org_nm
        
        para.startPoint = start
        para.endPoint = end
        para.appScheme =  appScheme + "://MapSearchPig.navigation"
        
        BMKNavigation.openBaiduMapNavigation(para)
        
    }
    
    func collect_cell_clicked() {
        HttpRequest.http_request_insertUserCollect(session_key: constant_session_key, user: constant_user.z_usrname, zc_id: self.z_org_id) { (json_result) -> Void in
            
            //print(json_result)
            if json_result != nil{
                
                if json_result["flag"].stringValue == "true" {
                    SVProgressHUD.showInfoWithStatus("收藏成功", maskType: SVProgressHUDMaskType.Gradient)
                    self.is_collected = true
                    self.table_view.reloadData()
                }
                else{
                    SVProgressHUD.showInfoWithStatus("收藏错误,稍后再试", maskType: SVProgressHUDMaskType.Gradient)
                }
            }
            else{
                SVProgressHUD.showInfoWithStatus("服务器错误,稍后再试", maskType: SVProgressHUDMaskType.Gradient)
            }
        }
    }
    
    func check_is_collected() {
        HttpRequest.http_request_addColAvailable(session_key: constant_session_key, username: constant_user.z_usrname, usercolitem: self.z_org_id) { (json_result) -> Void in
            //print(json_result)
            if json_result != nil{
                if json_result["flag"].stringValue == "false" {
                    self.is_collected = true
                    self.table_view.reloadData()
                }
                else{
                    SVProgressHUD.showInfoWithStatus("请求错误,稍后再试", maskType: SVProgressHUDMaskType.Gradient)
                }
            }
            else{
                SVProgressHUD.showInfoWithStatus("服务器错误,稍后再试", maskType: SVProgressHUDMaskType.Gradient)
            }
        }

    }
    
}
