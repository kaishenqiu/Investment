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




