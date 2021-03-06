//
//  ITService.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import Moya

public enum ITService {
    case login(username: String, password: String)
    case register(mobile: String, password: String, code:String)
    case userassert
    
    case userinfo
    
    case projectList(page:String)
    case projectinfo(no:String)
    case projectinvest(pid:String, money:String, pay_pwd:String)
    case investlist(id:String)
    case myinvest

    
    case goodsList(page:String)
    case goodsinfo(goods_no:String)
    
    case myorder(page:String)
    
    
    case mybank
    case bindbank(account_nm:String, bank_no:String, bank_nm:String)
    case recharge(money:String, bank_id:String, pay_pwd:String)
    case draw(money:String, bank_id:String, pay_pwd:String)
    
    
    case arealist(pid:String)
    case createaddress(username:String, province:String, city:String, district:String, address:String, mobile:String)
    case myaddress
    case deladdress(id:String)
    case defauaddress(id:String,defau:String)
    case updateaddress(id:String,username:String,province:String,city:String,district:String,address:String,mobile:String,defau:String)
    
    case makeorder(goods_listpno:String,goods_listnumber:String, address_id:String)
    case goodspay(order_no:String, pay_pwd:String)

    
    case setpaypwd(pay_pwd:String, mobile:String, code:String)
    

    
}


extension ITService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://10.0.13.93/api/")!
    }
    
    public var path: String {
        switch self {
            
        case .login:
            return "login"
        case .register:
            return "register"
        case .userassert:
            return "user/assert"
        case .userinfo:
            return "user/info"
            
        case .projectList:
            return "project/list"
        case .projectinfo:
            return "project/info"
        case .projectinvest:
            return "project/invest"
        case .investlist:
            return "project/investlist"
        case .myinvest:
            return "user/myInvest"
        case .goodsList:
            return "goods/list"
        case .goodsinfo:
            return "goods/info"
        case .myorder:
            return "user/myOrder"
            
        case .mybank:
            return "user/mybank"
        case .bindbank:
            return "user/bindbank"
        case .recharge:
            return "user/recharge"
        case .draw:
            return "user/draw"
            
        case .arealist:
            return "area/list"
        case .createaddress:
            return "user/createaddress"
        case .myaddress:
            return "user/myaddress"
        case .deladdress:
            return "user/deladdress"
        case .defauaddress:
            return "user/updateaddress"
        case .updateaddress:
            return "user/updateaddress"
        
        case .makeorder:
            return "goods/makeorder"
        case .goodspay:
            return "goods/pay"
        case .setpaypwd:
            return "user/setpaypwd"
        }
    }
    
    public var method: Moya.Method { return .post }
    public var parameters: [String : Any]? {
        
        switch self {
        case .login(let name, let pass):
            return ["username": name, "password": pass]
            
        case .register(let mobile,let password,let code):
            return ["mobile": mobile, "password": password, "code":code ]
        case .userassert():
            return [:]
        case .userinfo():
            return [:]
        
        case .projectList(let page):
            return ["page":page]
        case .projectinfo(let no):
            return ["no":no]
        case .projectinvest(let pid,let money,let pay_pwd):
            return ["pid":pid, "money":money, "pay_pwd":pay_pwd]
        case .investlist(let id):
            return ["id":id]
        case .myinvest():
            return [:]
        case .goodsList(let page):
            return ["page":page]
        case .goodsinfo(let goods_no):
            return ["goods_no":goods_no]
        case .myorder(let page):
            return ["page":page]
            
        case .mybank():
            return [:]
        case .bindbank(let account_nm,let bank_no,let bank_nm):
            return ["account_nm":account_nm, "bank_no":bank_no, "bank_nm":bank_nm]
        case .recharge(let money,let bank_id,let pay_pwd):
            return ["money":money, "bank_id":bank_id, "pay_pwd":pay_pwd]
        case .draw(let money,let bank_id,let pay_pwd):
            return ["money":money, "bank_id":bank_id, "pay_pwd":pay_pwd]
            
        case .arealist(let pid):
            return ["pid": pid]
        case .createaddress(let username,let province,let city,let district,let address,let mobile):
            return ["username":username, "province":province, "city":city, "district":district, "address":address, "mobile":mobile]
        case .myaddress():
            return [:]
        case .deladdress( let id):
            return ["id":id]
        case .defauaddress(let id,let defau):
            return ["id":id, "defau":defau]
        case .updateaddress(let id,let username,let province,let city,let district,let address,let mobile,let defau):
            return ["id":id,"username":username, "province":province, "city":city, "district":district, "address":address, "mobile":mobile,"defau":defau]
        
        case .makeorder(let goods_listpno,let goods_listnumber, let address_id):
            return ["goods_list[0][pno]":goods_listpno,"goods_list[0][number]":goods_listnumber,"address_id":address_id]
        case .goodspay(let order_no,let pay_pwd):
            return ["order_no":order_no, "pay_pwd":pay_pwd]
        case .setpaypwd(let pay_pwd,let mobile,let code):
            return ["pay_pwd":pay_pwd,"mobile":mobile,"code":code]
        }
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        return true
    }
    
    public var multipartBody: [MultipartFormData]? {
        return []
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}
