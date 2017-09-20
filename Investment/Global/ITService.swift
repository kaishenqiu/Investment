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
    case goodsList(page:String)
    case mybank
    case bindbank(account_nm:String, bank_no:String, bank_nm:String)
    
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
        case .goodsList:
            return "goods/list"
        case .mybank:
            return "user/mybank"
        case .bindbank:
            return "user/bindbank"
        
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
        case .goodsList(let page):
            return ["page":page]
        case .mybank():
            return [:]
        case .bindbank(let account_nm,let bank_no,let bank_nm):
            return ["account_nm":account_nm, "bank_no":bank_no, "bank_nm":bank_nm]

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
