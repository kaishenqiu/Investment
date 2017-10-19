//
//  AppDefine.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/5/5.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit

// 屏幕宽度
let screenHeight = UIScreen.main.bounds.height
// 屏幕高度
let screenWidth = UIScreen.main.bounds.width



func SCREEN_ADAPTER_H (x:Float) -> CGFloat
{
    return CGFloat(x/1334.00) * screenHeight
}

func SCREEN_ADAPTER_W (x:Float) -> CGFloat
{
    return CGFloat(x/750.00) * screenWidth
}

let GlobalColor = #colorLiteral(red: 0.9294117647, green: 0.2352941176, blue: 0.2196078431, alpha: 1)

public var AddressArray = [AddrModel]()


let TOKEN = "token"
let LOGINNAME = "loginname"
let ID = "loginid"
let MONEY = "money"
let TOKENAuthorization = "tokenAuthorization"

//临时搜猪key
//var constant_session_key = String()
//var search_pig_list = [MapSearchPig]()

// MARK: - 通知标识
let CALL_CARD_REFRESH = "callcardrefresh"
let CALL_ADDR_REFRESH = "calladdrrefresh"
let CALL_JUMPTOORDER = "calljumptoorder"

let statusGuide = ["-4":"退款失败","-3":"取消退款","-2":"取消订单","-1":"付款失败","0":"未付款","1":"已付款","2":"退款中","3":"退款完成","4":"发货","5":"完成"]
let statusColorGuide = ["-4":"eeeeee","-3":"eeeeee","-2":"eeeeee","-1":"eeeeee","0":"ED3C38","1":"437EED","2":"eeeeee","3":"eeeeee","4":"eeeeee","5":"eeeeee"]


public var provinceDic: [String:String] = [:]
public var cityDic: [String:String] = [:]
public var districtDic: [String:String] = [:]

public var provinceNameArray = [String]()
public var cityNameArray = [String]()
public var districtNameArray = [String]()

//当前日期
func today_s() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let curDate = formatter.string(from: Date())
    return curDate
}
//本月的1号
func today_s_1() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM"
    let curDate = formatter.string(from: Date()) + "-01"
    return curDate
}
func today_year() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let curDate = formatter.string(from: Date())
    return curDate
}
// 当前 年的 一月份
func currentYear_firstMonth() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let curDate = formatter.string(from: Date()) + "-01"
    return curDate
}

// 上一个月份
func pretMonth() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    let curM = formatter.string(from: Date())
    let preM = Int(curM)! - 1
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "yyyy"
    if preM > 9 {
        let preMont = formatter2.string(from: Date()) + "-\(preM)"
        return preMont
    } else {
        let preMont = formatter2.string(from: Date()) + "-0\(preM)"
        return preMont
    }
}

// 上一个月1号
func pretMonth_firstDay() -> String {
    return pretMonth() + "-01"
}

func today_month() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM"
    let curDate = formatter.string(from: Date())
    return curDate
}

func today_pre_year_s_1(_ predays: Int) -> String {

    let interval =  TimeInterval(24 * 60 * 60 * predays)

    let data = Date(timeIntervalSinceNow: -interval)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let curDate = formatter.string(from: data) + "-01-01"
    return curDate
}

func today_pre_s_1(_ predays: Int) -> String {

    let interval =  TimeInterval(24 * 60 * 60 * predays)

    let data = Date(timeIntervalSinceNow: -interval)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM"
    let curDate = formatter.string(from: data) + "-01"
    return curDate
}

func today_pre_s(_ predays: Int) -> String {

    let interval =  TimeInterval(24 * 60 * 60 * predays)

    let data = Date(timeIntervalSinceNow: -interval)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let curDate = formatter.string(from: data)
    return curDate
}

extension String{
    /// 将十六进制颜色转伟UIColor
    /// - Returns: UIColor
    public func toUIColor() -> UIColor {
        //处理数值
        var cString = self.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            return UIColor.white
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
}



