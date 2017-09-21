//
//  GlobalFunction.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/6/14.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit



public func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}


public func isTelNumber(num:String)->Bool
{
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((47|33|53|77|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true))
    {
        return true
    }
    else
    {
        return false
    }
}



// MARK: - 获取数据字典
public func getDataDictionary() {
    
    ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:"0"), successHandle: { (result) in
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
                    provinceDic.updateValue(k, forKey: v)
                }
            }
        }
        provinceNameArray = Array(provinceDic.keys)
        ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:provinceDic[provinceNameArray[0]]!), successHandle: { (result) in
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
            ANBaseNetWork.sharedInstance.networkForListNOHUD(.arealist(pid:cityDic[cityNameArray[0]]!), successHandle: { (result) in
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
                
            }) { (_) in
                
            }
            
        }) { (_) in
            
        }
        
        
    }) { (_) in
        
    }
    

    
}
