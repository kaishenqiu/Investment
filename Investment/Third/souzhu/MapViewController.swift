//
//  ViewController.swift
//  AWPigSearch
//
//  Created by 数据库实验室 on 15/8/1.
//  Copyright (c) 2015年 PonyMuch. All rights reserved.
//


//latitude:   24.436109
//longtitude: 118.119543

import UIKit
import SVProgressHUD

class MapViewController: UIViewController, BMKMapViewDelegate, BMKLocationServiceDelegate,BMKCloudSearchDelegate, BMKGeoCodeSearchDelegate, ASValueTrackingSliderDataSource, DOPNavbarMenuDelegate,MLPAutoCompleteTextFieldDelegate,MLPAutoCompleteTextFieldDataSource{
    
    @IBOutlet weak var label_radius: UILabel!
    
    @IBOutlet weak var slide_bar: ASValueTrackingSlider!
    
    @IBOutlet weak var bar_item_city: UIBarButtonItem!
    
    @IBOutlet weak var auto_textfield: MLPAutoCompleteTextField!
    
    @IBOutlet weak var selectSwitch: UISwitch!
    ///搜索结果集
    //var search_pig_list = [MapSearchPig]()
    
    ///待添加标注集
    var annotations_list = [BMKPointAnnotation]()
    
    ///统计菜单
    var _menu: DOPNavbarMenu!
    
    ///百度用户定位服务
    var baidu_user_location: BMKLocationService!
    
    ///百度云检索
    var baidu_cloud_search: BMKCloudSearch!
    
    ///百度反向编码
    var baidu_geocode_search: BMKGeoCodeSearch!
    
    ///定位信息保存变量
    var current_location_coor: CLLocationCoordinate2D?
    
    ///当前搜索半径
    var current_search_radius = 0
    
    ///当前搜索区域
    var current_search_region = String()
    
    ///当前搜索页数
    var current_page = 0
    
    ///按住选择生成的标注
    var selected_annotation: BMKPointAnnotation!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    ///百度地图
    var baidu_map_view : BMKMapView!
    
    // 是否定位成功
    var isLocated:Bool = false 
    
    //MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地图"
        
        baidu_map_view = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        auto_textfield.autoCompleteDelegate = self
        auto_textfield.autoCompleteDataSource = self
        
        
        //设置BarItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "统计", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapViewController.open_menu(sender:)))
        
        //设置tabbar选中颜色
        self.tabBarController?.tabBar.tintColor = UIColor.blue
        
        //左上角bar_item
        let attribute = [NSFontAttributeName:UIFont(name: "Helvetica", size: 14)!]
        self.bar_item_city.setTitleTextAttributes(attribute, for: UIControlState.normal)
        
        //初始化定位服务
        self.baidu_user_location = BMKLocationService()
        
        self.baidu_map_view.isRotateEnabled = false
        self.baidu_map_view.isTrafficEnabled = false
        self.baidu_map_view.isZoomEnabledWithTap = false
        
        //设置缩放标尺
        self.baidu_map_view.showMapScaleBar = true
        self.baidu_map_view.mapScaleBarPosition = CGPoint(x:10, y:45)
        //指南针
        //self.baidu_map_view.compassPosition = CGPointMake(200, 10)
        
        //设置地图类型
        self.baidu_map_view.mapType = (UInt)(BMKMapTypeStandard)
        
        //初始化百度地图云检索
        self.baidu_cloud_search = BMKCloudSearch()
        
        //选择的标注展示到最前
        self.baidu_map_view.isSelectedAnnotationViewFront = true
        
        
        //两秒后自动定位
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
             self.user_locating()
        }
        
        
  
        
        //滑动条(第三方框架)
        // if false , the events will happen after the end of its value changed.
        self.slide_bar.isContinuous = false
        self.slide_bar.popUpViewCornerRadius = 10
        self.slide_bar.setMaxFractionDigitsDisplayed(0)
        self.slide_bar.popUpViewColor = UIColor.blue.withAlphaComponent(0.8)
        self.slide_bar.font = UIFont(name: "Helvetica", size: 12)
        self.slide_bar.textColor = .white
        self.slide_bar.dataSource = self
        
        //初始化[百度]位置反编码
        self.baidu_geocode_search = BMKGeoCodeSearch()
        
        
        
        self.view.addSubview(baidu_map_view)
        
        self.view.bringSubview(toFront: label_radius)
        self.view.bringSubview(toFront: slide_bar)
        self.view.bringSubview(toFront: auto_textfield)
        self.view.bringSubview(toFront: selectSwitch)
        //    self.view.bringSubviewToFront(releaseLabel)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.baidu_map_view.delegate = self
        self.baidu_user_location.delegate = self
        self.baidu_cloud_search.delegate = self
        self.baidu_geocode_search.delegate = self
        
        if constant_session_key == ""{
            SVProgressHUD.showInfo(withStatus: "请先登录再搜猪哦")
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.baidu_map_view.delegate = nil
        self.baidu_user_location.delegate = nil
        self.baidu_cloud_search.delegate = nil
        self.baidu_geocode_search.delegate = nil
    }
    
    
    
    
    //MARK: - AutoComplete
    func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!) -> [AnyObject]! {
        
        return NSArray(contentsOfFile: Bundle.main.path(forResource: "city", ofType: "plist")!)! as [AnyObject]
    }
    
    func autoCompleteTextField(textField: MLPAutoCompleteTextField!, didSelectAutoCompleteString selectedString: String!, withAutoCompleteObject selectedObject: MLPAutoCompletionObject!, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        self.current_search_region = selectedString
        
        self.baidu_map_view.zoomLevel = 5.5
        
        self.search_pig_by_region(region: selectedString)
        
    }
    
    
    
    //MARK: 第三方滑动工具代理
    func slider(_ slider: ASValueTrackingSlider!, stringForValue value: Float) -> String! {
        return "当前选择距离:\((Int)(value * 3000))千米"
    }
    
    
    
    
    
    //MARK:点击地图空白处代理
    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    
    //MARK:点击地图标签代理
    func mapView(mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
    }
    
    
    
    
    //MARK: 长按地图某一点代理（范围搜索）
    func mapview(mapView: BMKMapView!, onLongClick coordinate: CLLocationCoordinate2D) {
        
        self.baidu_user_location.stopUserLocationService()
        
        self.current_location_coor = coordinate
        
        let point_annotation = BMKPointAnnotation()
        
        point_annotation.coordinate = coordinate
        
        point_annotation.title = "选定中心"
        
        point_annotation.subtitle = "自定义查看中心"
        
        self.selected_annotation = point_annotation
        
        self.search_pig_farm(radius: (Int)(self.slide_bar.value * 300000))
        
    }
    
    
    
    
    //MARK: 覆盖图层绘制代理
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView!{
        
//        if overlay.isKind(of: BMKCircle) {
//            
//            let circle_view:BMKCircleView = BMKCircleView(overlay: overlay)
//            
//            circle_view.strokeColor = UIColor.blue.withAlphaComponent(0.15)
//            
//            circle_view.fillColor = UIColor.blue.withAlphaComponent(0.15)
//            
//            circle_view.lineWidth = 1
//            
//            return circle_view
//        }
//            
//        else {
//            return nil
//        }
    }
    
    
    
    
    //MARK: 绘制标注物代理
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        var new_annotation: BMKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation_id") as? BMKPinAnnotationView
        
        if (new_annotation == nil) {
            new_annotation = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation_id")
            
            
            new_annotation!.annotation = annotation
            
            new_annotation!.pinColor = (UInt)(BMKPinAnnotationColorRed)
            
            new_annotation!.animatesDrop = true
            
            new_annotation!.isDraggable = false
   
        }
        
        
        
        
        //自定义气泡
        if annotation.title!() != "选定中心" {
            
            let index = find_index_in_list(id_key: annotation.title!())

            //            if self.selectSwitch.on == true && search_pig_list[index].z_use_tag == "0" {
            //               self.baidu_map_view.removeAnnotation(annotation)
            //                return nil
            new_annotation!.image = UIImage(named: "pin_pig")
            // }

            if search_pig_list.count == 0 || index < 0  {
                return nil
            }
            
            if Int(search_pig_list[index].z_sale_piglet)! > 0 || Int(search_pig_list[index].z_sow_num)! > 0 || Int(search_pig_list[index].z_sale_pig)! > 0 || Int(search_pig_list[index].z_sale_sow)! > 0 {
                new_annotation!.image = UIImage(named: "pin_red")
            }
            
            
            //MARK: - 振坤记单独图标
            if search_pig_list[index].z_org_nm == "振坤记食品有限公司" {
                new_annotation!.image = UIImage(named: "pin_zkj")
            }
            
            
            let custome_view = UIView(frame: CGRect(x:0,y: 0,width: 160,height: 170))
            
            custome_view.backgroundColor = .clear
            
            custome_view.layer.cornerRadius = 10
            
            custome_view.clipsToBounds = true
            
            let image_view = UIImageView(frame: custome_view.frame)
            
            image_view.image = UIImage(named: "paopao")
            
            image_view.alpha = 0.8
            
            custome_view.addSubview(image_view)
            
            let label = UILabel(frame: CGRect(x:10,y: 10,width: 140,height: 20))
            
            label.textAlignment = NSTextAlignment.center
            
            label.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
            
            label.text = search_pig_list[index].z_org_nm
            
            label.tintColor = UIColor.darkGray
            
            label.font = UIFont(name: "Helvetica-Bold", size: 15)
            
            custome_view.addSubview(label)
            
            //待销售仔猪 母猪存栏数 待销售肥猪 待销售母猪
            let label1 = UILabel(frame: CGRect(x:15,y: 36,width: 145,height: 20))
            label1.text = "待销售仔猪:        " + search_pig_list[index].z_sale_piglet
            label1.tintColor = UIColor.darkGray
            label1.font = UIFont(name: "Helvetica", size: 14)
            custome_view.addSubview(label1)
            
            let label2 = UILabel(frame: CGRect(x:15,y: 69,width: 145,height: 20))
            label2.text = "母猪存栏数:        " + search_pig_list[index].z_sow_num
            label2.tintColor = UIColor.darkGray
            label2.font = UIFont(name: "Helvetica", size: 14)
            custome_view.addSubview(label2)
            
            
            let label5 = UILabel(frame: CGRect(x:15,y: 102,width: 145,height: 20))
            label5.text = "待销售肥猪:        " + search_pig_list[index].z_sale_pig
            label5.tintColor = UIColor.darkGray
            label5.font = UIFont(name: "Helvetica", size: 14)
            custome_view.addSubview(label5)
            
            let label6 = UILabel(frame: CGRect(x:15,y: 135,width: 145,height: 20))
            label6.text = "待销售种猪:        " + search_pig_list[index].z_sale_sow
            label6.tintColor = UIColor.darkGray
            label6.font = UIFont(name: "Helvetica", size: 14)
            custome_view.addSubview(label6)
            
            new_annotation?.paopaoView = BMKActionPaopaoView(customView: custome_view)
        }
        
        
        return new_annotation
        
        
    }
    
    
    
    //MARK: 根据猪场ID搜锁其在LIST中的位置
    func find_index_in_list(id_key: String) -> Int {
        var index = -1
        for i in 0 ..< search_pig_list.count   {
            if search_pig_list[i].id_key == id_key {
                index = i
                break
            }
        }
        return index
    }
    
    
    
    
    //MARK: 气泡点击代理（点击后要检索猪场详细的数据）
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!){
        
        if constant_session_key == "" {
            SVProgressHUD.showInfo(withStatus: "请登录后查看")
            return
        }
        
        if view.annotation.title!() == "选定中心" {
            return
        }
        
        if view.annotation.title!() == "我的位置" {
            return
        }
        
        let index = find_index_in_list(id_key: view.annotation.title!())
        // MARK: - storyboard 有bug
        let view = self.storyboard?.instantiateViewController(withIdentifier: "farm_detail_view") as! FarmDetailViewController
        
        view.z_sale_piglet = search_pig_list[index].z_sale_piglet
        view.z_sow_num = search_pig_list[index].z_sow_num
        view.z_sale_pig = search_pig_list[index].z_sale_pig
        view.z_sale_sow = search_pig_list[index].z_sale_sow
        
        
        view.z_org_nm = search_pig_list[index].z_org_nm
        view.z_org_id = search_pig_list[index].id_key
        
        
        view.z_latitude = search_pig_list[index].z_latitude
        view.z_longitude = search_pig_list[index].z_longitude
        
        
        view.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    //MARK: 选择标注代理
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        
        self.baidu_map_view.bringSubview(toFront: view)
        
        self.baidu_map_view.setNeedsDisplay()
        
    }
    
    //MARK: 将要开始定位代理
    func willStartLocatingUser() {
        print("开始定位")
    }
    
    //MARK: 停止定位代理
    func didStopLocatingUser() {
        print("停止定位")
    }
    //MARK: 定位失败代理
    func didFailToLocateUserWithError(error: NSError!) {
        isLocated = false
        print("定位失败")
    }
    
    //MARK: 用户方向改变代理
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        self.baidu_map_view.updateLocationData(userLocation)
    }
    
    //MARK: 用户位置更新代理
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        
        self.baidu_map_view.updateLocationData(userLocation)
        
        self.current_location_coor = userLocation.location.coordinate
        
        //地理位置反编码
        let reverse_option = BMKReverseGeoCodeOption()
        
        reverse_option.reverseGeoPoint = userLocation.location.coordinate
        
        self.baidu_geocode_search.reverseGeoCode(reverse_option)
        
    }
    
    //MARK: 滑动条值改变
    @IBAction func slidebar_change(sender: UISlider) {
        
        if isLocated == false {
            sender.value = 0.0
            SVProgressHUD.showInfo(withStatus: "先定位再搜猪")
        }
        
        self.label_radius.text = "距离半径 : \((Int)(sender.value * 300000)) 米"
        
        if sender.value < 0.1 {
            self.baidu_map_view.zoomLevel = 12
        }
        if sender.value >= 0.1 {
            self.baidu_map_view.zoomLevel = 11
        }
        if sender.value >= 0.2 {
            self.baidu_map_view.zoomLevel = 10
        }
        if sender.value >= 0.3 {
            self.baidu_map_view.zoomLevel = 9
        }
        if sender.value >= 0.6 {
            self.baidu_map_view.zoomLevel = 8.5
        }
        if self.current_location_coor != nil {
            self.baidu_map_view.centerCoordinate = self.current_location_coor!
        }
        
        
        self.search_pig_farm(radius: (Int)(sender.value * 300000))
        
    }
    
    //MARK: 圆形区域云检索猪场
    func search_pig_farm(radius: Int) {
        
        self.annotations_list = [BMKPointAnnotation]()
        
        self.current_page = 0
        
        self.current_search_radius = radius
        
        search_pig_list.removeAll(keepingCapacity: false)
        //添加圆形覆盖 范围搜索
        if let location = self.current_location_coor {
            
            let coordinates_circle = location
            
            let circle: BMKCircle = BMKCircle(center: coordinates_circle, radius: (CLLocationDistance)(radius))
            
            baidu_map_view.removeOverlays(baidu_map_view.overlays)
            
            baidu_map_view.add(circle)
            
        }
        else {
            print("当前未定位")
            return
        }
        
        self.baidu_map_view.removeAnnotations(baidu_map_view.annotations)
        
        self.baidu_map_view.addAnnotation(self.selected_annotation)
        //设定云检索参数
        let cloud_nearby_search = BMKCloudNearbySearchInfo()
        
        cloud_nearby_search.ak = "Ns6TdAKYbNaNjPiIURYNwbRz"
        
        cloud_nearby_search.geoTableId = 116973
        
        cloud_nearby_search.pageSize = 50
        
        cloud_nearby_search.pageIndex = self.current_page
        
        if let location = self.current_location_coor{
            cloud_nearby_search.location = "\(location.longitude),\(location.latitude)"
        }
        
        cloud_nearby_search.keyword = "*"
        
        cloud_nearby_search.radius = (Int32)(radius)
        
        let flag = self.baidu_cloud_search.nearbySearch(with: cloud_nearby_search)
        
        if flag == true {
            print("检索成功")
        }
        else {
            print("检索失败")
        }
    }
    
    //MARK: 区域检索猪场
    func search_pig_by_region(region: String) {
        
        self.annotations_list = [BMKPointAnnotation]()
        
        self.current_page = 0
        
        search_pig_list.removeAll(keepingCapacity: false)
        
        
        self.baidu_map_view.removeOverlays(baidu_map_view.overlays)
        
        self.baidu_map_view.removeAnnotations(baidu_map_view.annotations)
        
        
        //设定云检索参数
        let cloud_nearby_search = BMKCloudLocalSearchInfo()
        
        cloud_nearby_search.ak = "Ns6TdAKYbNaNjPiIURYNwbRz"
        
        cloud_nearby_search.geoTableId = 116973
        
        cloud_nearby_search.pageSize = 50
        
        cloud_nearby_search.pageIndex = self.current_page
        
        cloud_nearby_search.region = region
        
        cloud_nearby_search.keyword = "*"
        
        let flag = self.baidu_cloud_search.localSearch(with: cloud_nearby_search)
        
        if flag == true {
            print("检索成功")
        }
        else {
            print("检索失败")
        }
        
    }
    
    //MARK: 云检索代理后在地图上添加标注
    func onGetCloudPoiResult(poiResultList: [AnyObject]!, searchType type: Int32, errorCode error: Int32) {
        
        if constant_session_key == ""{
            
            SVProgressHUD.showInfo(withStatus: "请先登录再搜猪哦")
            
        }
        
        if type == Int32(BMK_CLOUD_NEARBY_SEARCH.rawValue) {
            print("周边圆形检索")
            
            if ( (Int32)(error) == (Int32)(BMKErrorOk.rawValue) )
            {
                let result = poiResultList[0] as! BMKCloudPOIList
                
                print("当前POI总数量 : \(result.total)  总页数 :\(result.pageNum)")
                
                if result.pois.count == 0 { return }
                
                var zc_id_string = (result.pois[0] as! BMKCloudPOIInfo).title!
                
                for i in 1 ..< result.pois.count  {
                    zc_id_string += ",\((result.pois[i] as! BMKCloudPOIInfo).title)"
                }
                
                if constant_session_key != ""
                {
 
                    HttpRequest.http_request_getOpenPig(session_key: constant_session_key, zc_id: zc_id_string, result_block: { (json_result) -> Void in
                        
                        print("json_result",json_result)
                        
                        if json_result != nil{
                            
                            if json_result["flag"].stringValue == "true" {
                                
                                var search_pig_one: MapSearchPig!
                                //待销售仔猪 母猪存栏数 待销售肥猪 待销售母猪
                                for json in json_result["info"].array! {
                                    //  print("json\(json)")
                                    
                                    search_pig_one = MapSearchPig()
                                    
                                    search_pig_one.z_address = json["z_address"].stringValue
                                    search_pig_one.z_logid = json["z_logid"].stringValue
                                    search_pig_one.z_staff_id = json["z_staff_id"].stringValue
                                    search_pig_one.z_rem = json["z_rem"].stringValue
                                    search_pig_one.id_key = json["id_key"].stringValue
                                    search_pig_one.z_org_nm = json["z_org_nm"].stringValue
                                    
                                    
                                    
                                    
                                    search_pig_one.z_sale_piglet = json["z_sale_piglet"].stringValue
                                    search_pig_one.z_sow_num = json["z_sow_num"].stringValue
                                    search_pig_one.z_sale_pig = json["z_sale_pig"].stringValue
                                    search_pig_one.z_sale_sow = json["z_sale_sow"].stringValue
                                    
                                    search_pig_one.z_latitude = json["z_latitude"].stringValue
                                    search_pig_one.z_longitude = json["z_longitude"].stringValue
                                    search_pig_one.z_use_tag = json["z_use_tag"].stringValue
                                    
                                    search_pig_list.append(search_pig_one)
                                }
                                
                                print("当前数量LLLLL\(search_pig_list.count)")
                                //MARK: - OKKK
                                //---
//                                print("result.POIs.count",result.POIs.count)
                                for i in 0 ..< result.pois.count  {
                                    let poi = result.pois[i] as! BMKCloudPOIInfo
                                    let item = BMKPointAnnotation()
                                    item.coordinate = CLLocationCoordinate2DMake((Double)(poi.longitude), (Double)(poi.latitude))
                                    item.title = poi.title
                                    let index = self.find_index_in_list(id_key: item.title)
//                                    print("index",index)
                                    if index >= 0 && index < search_pig_list.count{
                                        if search_pig_list[index].z_use_tag == "1" || self.selectSwitch.isOn == false {
                                            self.annotations_list.append(item)
                                        }
                                    }
                                }
                                
                                if result.pois.count < 50 {
                                    //获取数据后在地图上添加标注
                                    self.baidu_map_view.addAnnotations(self.annotations_list)
                                }
                                
                                if result.pois.count == 50 {
                                    //设定云检索参数
                                    let cloud_nearby_search = BMKCloudNearbySearchInfo()
                                    
                                    cloud_nearby_search.ak = "Ns6TdAKYbNaNjPiIURYNwbRz"
                                    
                                    cloud_nearby_search.geoTableId = 116973
                                    
                                    cloud_nearby_search.pageSize = 50
                                    
                                    self.current_page += 1
                                    
                                    cloud_nearby_search.pageIndex = self.current_page
                                    
                                    if let location = self.current_location_coor{
                                        cloud_nearby_search.location = "\(location.longitude),\(location.latitude)"
                                    }
                                    
                                    cloud_nearby_search.keyword = "*"
                                    
                                    cloud_nearby_search.radius = (Int32)(self.current_search_radius)
                                    
                                    let flag = self.baidu_cloud_search.nearbySearch(with: cloud_nearby_search)
                                    
                                    if flag == true {
                                        print("检索成功")
                                    }
                                    else {
                                        print("检索失败")
                                    }
                                }
                                //---
                                
                            }
                            else {
                                
                                UIAlertView(title: "温馨提示", message: "由于您长时间未使用搜猪或处于离线状态,为保证服务质量,请注销重新登录", delegate: self, cancelButtonTitle: "好的,这就去").show()
                                return
                            }
                        }
                        else{
                            SVProgressHUD.showInfo(withStatus: "服务器错误,稍后再试")
                        }
                    })
                }
                else {
                    
                    var search_pig_one: MapSearchPig!
                    for i in 0 ..< result.pois.count  {
                        search_pig_one = MapSearchPig()
                        search_pig_one.id_key = (result.pois[i] as! BMKCloudPOIInfo).title
                        search_pig_one.z_org_nm = "请登陆后查看"
                        search_pig_list.append(search_pig_one)
                    }
                }
                
                //---
                
                //---
                
            }
            else
            {
                print("发生错误 错误代码: \((Int32)(error))")
            }
        }
        
        if type == Int32(BMK_CLOUD_LOCAL_SEARCH.rawValue) {
            print("按地区检索")
            if ((Int32)(error) == (Int32)(BMKErrorOk.rawValue))
            {
                let result = poiResultList[0] as! BMKCloudPOIList
                
                print("当前POI总数量 : \(result.total)  总页数 :\(result.pageNum)")
                
                if result.pois.count == 0 { return }
                
                var zc_id_string = (result.pois[0] as! BMKCloudPOIInfo).title!
                
                for i in 1 ..< result.pois.count  {
                    zc_id_string += ",\((result.pois[i] as! BMKCloudPOIInfo).title)"
                }
                
                if constant_session_key != "" {
                    
                    
                    
                    HttpRequest.http_request_getOpenPig(session_key: constant_session_key, zc_id: zc_id_string, result_block: { (json_result) -> Void in
                        
                        //print(json_result)
                        
                        if json_result != nil{
                            
                            if json_result["flag"].stringValue == "true" {
                                
                                var search_pig_one: MapSearchPig!
                                //待销售仔猪 母猪存栏数  待销售肥猪 待销售母猪(种猪)
                                for json in json_result["info"].array! {
                                    
                                    search_pig_one = MapSearchPig()
                                    
                                    search_pig_one.z_address = json["z_address"].stringValue
                                    search_pig_one.z_logid = json["z_logid"].stringValue
                                    search_pig_one.z_staff_id = json["z_staff_id"].stringValue
                                    search_pig_one.z_rem = json["z_rem"].stringValue
                                    search_pig_one.id_key = json["id_key"].stringValue
                                    search_pig_one.z_org_nm = json["z_org_nm"].stringValue
                                    
                                    search_pig_one.z_sale_piglet = json["z_sale_piglet"].stringValue
                                    search_pig_one.z_sow_num = json["z_sow_num"].stringValue
                                    search_pig_one.z_sale_pig = json["z_sale_pig"].stringValue
                                    search_pig_one.z_sale_sow = json["z_sale_sow"].stringValue
                                    
                                    search_pig_one.z_latitude = json["z_latitude"].stringValue
                                    search_pig_one.z_longitude = json["z_longitude"].stringValue
                                    
                                    search_pig_list.append(search_pig_one)
                                }
                                
                                print("当前数量LLLLL\(search_pig_list.count)")
                                
                                //---
                                
                                for i in 0 ..< result.pois.count {
                                    let poi = result.pois[i] as! BMKCloudPOIInfo
                                    let item = BMKPointAnnotation()
                                    item.coordinate = CLLocationCoordinate2DMake((Double)(poi.longitude), (Double)(poi.latitude))
                                    item.title = poi.title
                                    
                                    self.annotations_list.append(item)
                                }
                                
                                if result.pois.count < 50 {
                                    //获取数据后在地图上添加标注
                                    self.baidu_map_view.addAnnotations(self.annotations_list)
                                }
                                
                                if result.pois.count == 50 {
                                    //设定云检索参数
                                    //设定云检索参数
                                    let cloud_nearby_search = BMKCloudLocalSearchInfo()
                                    
                                    cloud_nearby_search.ak = "Ns6TdAKYbNaNjPiIURYNwbRz"
                                    
                                    cloud_nearby_search.geoTableId = 116973
                                    
                                    cloud_nearby_search.pageSize = 50
                                    
                                    self.current_page += 1
                                    
                                    cloud_nearby_search.pageIndex = self.current_page
                                    
                                    cloud_nearby_search.region = self.current_search_region
                                    
                                    cloud_nearby_search.keyword = "*"
                                    
                                    let flag = self.baidu_cloud_search.localSearch(with: cloud_nearby_search)
                                    
                                    if flag == true {
                                        print("检索成功")
                                    }
                                    else {
                                        print("检索失败")
                                    }
                                }
                                //---
                            }
                            else {
                                UIAlertView(title: "温馨提示", message: "由于您长时间未使用搜猪或处于离线状态,为保证服务质量,请注销重新登录", delegate: self, cancelButtonTitle: "好的,这就去").show()
                                return
                            }
                        }
                        else{
                            SVProgressHUD.showInfo(withStatus: "服务器错误,稍后再试")
                        }
                    })
                }
                else {
                    
                    var search_pig_one: MapSearchPig!
                    for i in 0 ..< result.pois.count  {
                        search_pig_one = MapSearchPig()
                        search_pig_one.id_key = (result.pois[i] as! BMKCloudPOIInfo).title
                        search_pig_one.z_org_nm = "请登陆后查看"
                        search_pig_list.append(search_pig_one)
                    }
                }
                
                //---
                
                //---
            }
            else
            {
                print("发生错误 错误代码: \((Int32)(error))")
            }
        }
        
    }
    
    //MARK: 载入调整地图位置，定位到用户当前位置
    func user_locating() {
        
        let map_status = BMKMapStatus()
        
        map_status.fRotation = 0
        
        map_status.fOverlooking = 0
        
        map_status.fLevel = 14
        
        baidu_map_view.setMapStatus(map_status, withAnimation: true)
        
        self.baidu_user_location.startUserLocationService()
        //普通态 ［跟随态］ 罗盘态
        self.baidu_map_view.showsUserLocation = false
        
        self.baidu_map_view.userTrackingMode = BMKUserTrackingModeFollow
        
        self.baidu_map_view.showsUserLocation = true
    }
    
    //MARK: 地理反向编码代理
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if result != nil {
            self.bar_item_city.title = " " + result.addressDetail.city
            isLocated = true
        }
    }
    
    //MARK: 统计已搜索数据
    func pig_count_caculate() -> (z_sale_piglet: String, z_sow_num: String, z_sale_pig: String, z_sale_sow: String)? {
        if search_pig_list.count == 0 {return nil}
        else {
            
            var sale_piglet_count = 0
            var sow_num_count = 0
            var sale_pig_count = 0
            var sale_sow_count = 0
            
            for one: MapSearchPig in search_pig_list {
                sale_piglet_count += (one.z_sale_piglet as NSString).integerValue
                sow_num_count += (one.z_sow_num as NSString).integerValue
                
                sale_pig_count += (one.z_sale_pig as NSString).integerValue
                sale_sow_count += (one.z_sale_sow as NSString).integerValue
            }
            return (z_sale_piglet: "\(sale_piglet_count)", z_sow_num: "\(sow_num_count)", z_sale_pig: "\(sale_pig_count)", z_sale_sow: "\(sale_sow_count)")
        }
    }
    
    
    //MARK: - 统计数据 DOPNavbarMenu Delegate
    func menu() -> DOPNavbarMenu {
        
        let item_1, item_2, item_5, item_6: DOPNavbarMenuItem!
        if let caculate = pig_count_caculate(){
            
            item_1 = DOPNavbarMenuItem(title: "待销售仔猪:       \(caculate.z_sale_piglet)", icon: UIImage(named: "pig_type_1"))
            
            item_2 = DOPNavbarMenuItem(title: "母猪存栏数:       \(caculate.z_sow_num)", icon: UIImage(named: "pig_type_2"))
            
            
            item_5 = DOPNavbarMenuItem(title: "待销售肥猪:       \(caculate.z_sale_pig)", icon: UIImage(named: "pig_type_5"))
            
            item_6 = DOPNavbarMenuItem(title: "待销售母猪:       \(caculate.z_sale_sow)", icon: UIImage(named: "pig_type_4"))
        }
        else {
            item_1 = DOPNavbarMenuItem(title: "待销售仔猪:          0", icon: UIImage(named: "pig_type_1"))
            
            item_2 = DOPNavbarMenuItem(title: "母猪存栏数:          0", icon: UIImage(named: "pig_type_2"))
            
            
            item_5 = DOPNavbarMenuItem(title: "待销售肥猪:          0", icon: UIImage(named: "pig_type_5"))
            
            item_6 = DOPNavbarMenuItem(title: "待销售种猪:          0", icon: UIImage(named: "pig_type_4"))
        }
        
        _menu = DOPNavbarMenu(items: [item_1, item_2, item_5, item_6], width: self.view.dop_width, maximumNumberInRow: 2)
        
        _menu.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        
        _menu.separatarColor = UIColor.white.withAlphaComponent(0.8)
        
        _menu.delegate = self
        
        return _menu
    }
    
    func open_menu(sender: AnyObject) {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if self.menu().isOpen == true {
            self.menu().dismiss(withAnimation: true)
        } else {
            self.menu().show(in: self.navigationController)
        }
    }
    
    func didShowMenu(menu: DOPNavbarMenu!) {
        self.navigationItem.rightBarButtonItem?.title = "统计"
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func didDismissMenu(menu: DOPNavbarMenu!) {
        self.navigationItem.rightBarButtonItem?.title = "统计"
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func didSelectedMenu(_ atmenu: DOPNavbarMenu!, at index: Int) {
        print("\(index)")
    }
    
    
    @IBAction func switchValueChange(sender: UISwitch) {
        // self.onGetCloudPoiResult([AnyObject]!, searchType: Int32, errorCode: Int32)
    }
    
    
    //MARK: - 点击左上角图标再次定位
    @IBAction func left_bar_clicked(sender: UIBarButtonItem) {
        self.user_locating()
    }
}

