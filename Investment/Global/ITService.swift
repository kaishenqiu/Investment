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
    
    
    case arealist(pid:String)
    case createaddress(username:String, province:String, city:String, district:String, address:String, mobile:String)
    case myaddress
    case deladdress(id:String)
    
    case makeorder(goods_list:String, address_id:String)
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
        case .arealist:
            return "area/list"
        case .createaddress:
            return "user/createaddress"
        case .myaddress:
            return "user/myaddress"
        case .deladdress:
            return "user/deladdress"
        
        case .makeorder:
            return "goods/makeorder"
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
        case .arealist(let pid):
            return ["pid": pid]
        case .createaddress(let username,let province,let city,let district,let address,let mobile):
            return ["username":username, "province":province, "city":city, "district":district, "address":address, "mobile":mobile]
        case .myaddress():
            return [:]
        case .deladdress( let id):
            return ["id":id]
        case .makeorder(let goods_list, let address_id):
            return ["goods_list":goods_list,"address_id":address_id]
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
