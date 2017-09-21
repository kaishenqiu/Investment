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
            self.getData(pid: provinceDic[provinceNameArray[row]]!,component: component)
           break;
        case 1:
            self.getData(pid: cityDic[cityNameArray[row]]!,component: component)
            break;
        case 2:
           break;
        default:
            break;
        }
        addrField.text = provinceStr + cityStr + districtStr
    }
    
    private func getData(pid:String,component:Int) {
        
        // MARK: - 获取品种
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:pid), successHandle: { (result) in
            for dic in result {
                var k = ""
                var v = ""
                if component == 0 {
                 cityNameArray.removeAll()
                 cityDic.removeAll()
                }
                if component == 1 {
                    districtNameArray.removeAll()
                    districtDic.removeAll()
                }
                
                for (key, value) in dic {
                    if key == "key"{
                        k = value.stringValue
                    }
                    if key == "name"{
                        v = value.stringValue
                    }
                    if v != ""{
                        switch (component) {
                        case 0:
                            //把 名称当做key ，到时直接用名称查出  id
                            cityDic.updateValue(k, forKey: v)
                            break;
                        case 1:
                            districtDic.updateValue(k, forKey: v)
                            break;

                        default:
                            break;
                        }
  
                    }
                }
                if component == 0 {
                    cityNameArray = Array(cityDic.keys)
                    self.getData(pid: cityDic[cityNameArray[0]]!,component: 1)
                }
                if component == 1 {
                   districtNameArray = Array(districtDic.keys)
                }
            }
            
        }) { (_) in
            
        }
        print(cityNameArray)
        print(districtNameArray)
        pickerView.reloadAllComponents()
        
    }

    @IBAction func saveAction(_ sender: Any) {
//        guard let name = nameField.text, name.characters.count > 0 else {
//            SVProgressHUD.showError(withStatus: "请输入账号")
//            return
//        }
//        guard let bankno = bank_no.text, bankno.characters.count > 0 else {
//            SVProgressHUD.showError(withStatus: "请输入卡号")
//            return
//        }
//        guard let banknm = bank_nm.text, banknm.characters.count > 0 else {
//            SVProgressHUD.showError(withStatus: "请输入开户行")
//            return
//        }
//        
//        
//        ANBaseNetWork.sharedInstance.networkForBoolWithHeader(.createaddress(username: name, province: <#T##String#>, city: <#T##String#>, district: <#T##String#>, address: <#T##String#>, mobile: <#T##String#>), successHandle: { (result) in
//            SVProgressHUD.showInfo(withStatus: "新增地址成功")
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CALL_CARD_REFRESH), object: nil)
//            
//            self.navigationController!.popViewController(animated: true)
//            
//            
//        }, errorHandle: { (error) in
//            SVProgressHUD.showInfo(withStatus: error)
//        })

        
        
    }
}
