//
//  ThirdController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class ThirdController: UIViewController,BMKMapViewDelegate {
    var simingLatLon = CLLocationCoordinate2DMake(24.552481,117.690624)

    @IBOutlet weak var _mapView: BMKMapView!
    var dataArray = [MapModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        _mapView.centerCoordinate = simingLatLon
        _mapView.zoomLevel = 12
        // Do any additional setup after loading the view.
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
        _mapView?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
        _mapView?.delegate = nil
    }
    
    // 根据anntation生成对应的View
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation is BMKPointAnnotation {
      
                    let annotationView = STMyAnnotationView(annotation: annotation, reuseIdentifier: "STMyAnnotationView")
                 annotationView.animatesDrop = true
                let anot = annotation as! STMyAnnotation
            
            annotationView.image = UIImage(named: "pin_blue")
          
            
            if dataArray.count == 0  {
                return nil
            }
            if let numstr = anot.model?.zSowNum {
                if Int(numstr) > 0  {
                    annotationView.image = UIImage(named: "pin_red")
                }
            }
           
            
            
            //MARK: - 振坤记单独图标
            if anot.model?.zOrgNm == "振坤记食品有限公司" {
                annotationView.image = UIImage(named: "pin_zkj")
            }
            
            

                    return annotationView
     
        }
        return nil
    }

    
    
    func getData() {
        
        Alamofire.request(URL(string:"http://app.zhuok.com.cn/szgl/map/getOpenPig")!, method: .post, parameters: ["session_key":"04D9FAC96E8DFF8CDC1995A64FB9EE61","zc_id":"3788428,1594386,4010937,4703943,3486945,2819650,1476979,3010415,3607980,3607533,3490706,3287227,2378835,3285024,3290013,3288299,3289280,3287783,1537355,2787834,1355481,3779867,3931328,3799900,4038016,3932008,3800614,3931098,3870942,2917115,3870032,3239178,2261097,5943548,3506658,5827653,5771366,3666755,5777819,4526136,9216870,3609486,3216811,2541995,4960025,1458535,4017471,5020048,3706088,984949"]).responseJSON { (response) in
            //校验是否有值
            guard let result = response.result.value else {
            
                SVProgressHUD.showError(withStatus: "请求出了点意外")
                return
            }
            let json = JSON(result)
            if json["flag"].stringValue == "true" {
                
                print(json["info"])
                if let result = json["info"].array {
                    for item in result {
                        let one = MapModel(json: item)
                        self.dataArray.append(one)
                    }
                }
                self.showAnnotation()
               
           
            } else {
         
            }
        }
    
    }
    
    func showAnnotation() {
        
        self._mapView.removeAnnotations(self._mapView.annotations)
   
 
                for index in 0..<self.dataArray.count{
                    let one  = self.dataArray[index]
                    let annotation = STMyAnnotation()
                    var coor = CLLocationCoordinate2D()
                    coor.latitude = Double(one.zLatitude!)!
                    coor.longitude = Double(one.zLongitude!)!
                    annotation.title = one.zOrgNm
                    annotation.coordinate = coor
                    annotation.model = one
                    self._mapView.addAnnotation(annotation)
                }
 
        
        
    
    }

}
