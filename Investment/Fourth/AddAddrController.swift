//
//  AddAddrController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/20.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddAddrController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addrField: UITextField!
    
    var provinceStr = ""
    var cityStr = ""
    var districtStr = ""

    @IBOutlet weak var detailAddrField: UITextField!
    //选择器
    var pickerView:UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建选择器
        pickerView=UIPickerView()
        pickerView.dataSource=self
        pickerView.delegate=self
        

        
        addrField.inputView = pickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceNameArray.count
        } else if component == 1 {
            return cityNameArray.count
        } else {
            return districtNameArray.count
            
        }
    }
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0 {
            return provinceNameArray[row]
        }else if component == 1 {
            return cityNameArray[row]
        }else {
            return districtNameArray[row]
        }
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        //根据列、行索引判断需要改变数据的区域
        switch (component) {
        case 0:
            provinceStr = provinceNameArray[row]
            self.getDataCity(pid: provinceDic[provinceStr]!)
           break;
        case 1:
            self.cityStr = cityNameArray[row]
            self.getDataDistrict(pid: cityDic[cityNameArray[row]]!)
            
            break;
        case 2:
            self.districtStr = districtNameArray[row]
           break;
        default:
            break;
        }
        addrField.text = provinceStr + cityStr + districtStr
    }
    
    private func getDataCity(pid:String) {
        
        // MARK: - 获取城市
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:pid), successHandle: { (result) in
            
            cityNameArray.removeAll()
            cityDic.removeAll()
            
            for dic in result {
                var k = ""
                var v = ""
              
 
                
                for (key, value) in dic {
                    if key == "key"{
                        k = value.stringValue
                    }
                    if key == "name"{
                        v = value.stringValue
                    }
                    if v != ""{
                   
                            //把 名称当做key ，到时直接用名称查出  id
                            cityDic.updateValue(k, forKey: v)
  
                    }
                }

            }
            cityNameArray = Array(cityDic.keys)
            self.cityStr = cityNameArray[0]
            self.getDataDistrict(pid: cityDic[self.cityStr]!)
            self.pickerView.reloadComponent(1)
            
        }) { (_) in
            
        }
        
       
        
    }
    private func getDataDistrict(pid:String) {
             // MARK: - 获取区县
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:pid), successHandle: { (result) in
            districtNameArray.removeAll()
            districtDic.removeAll()
            for dic in result {
                var k = ""
                var v = ""
       
                
                
                for (key, value) in dic {
                    if key == "key"{
                        k = value.stringValue
                    }
                    if key == "name"{
                        v = value.stringValue
                    }
                    if v != ""{
                        
                        //把 名称当做key ，到时直接用名称查出  id
                        districtDic.updateValue(k, forKey: v)
                        
                    }
                }
           
            }
            districtNameArray = Array(districtDic.keys)
            self.districtStr = districtNameArray[0]
            self.pickerView.reloadComponent(2)
            
        }) { (_) in
            
        }
        
    
        
        
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let name = nameField.text, name.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请输入姓名")
            return
        }
        guard let mobile = mobileField.text, mobile.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请输入手机")
            return
        }
        guard let detial = detailAddrField.text, detial.characters.count > 0 else {
            SVProgressHUD.showError(withStatus: "请输入详细地址")
            return
        }
        
        
        ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.createaddress(username: name, province: self.provinceStr, city: self.cityStr, district: self.districtStr, address: detial, mobile: mobile    ), successHandle: { (result) in
            SVProgressHUD.showInfo(withStatus: "新增地址成功")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CALL_ADDR_REFRESH), object: nil)
            
            self.navigationController!.popViewController(animated: true)
            
            
        }, errorHandle: { (error) in
            SVProgressHUD.showInfo(withStatus: error)
        })

        
        
    }
}
