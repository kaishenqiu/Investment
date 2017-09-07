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
    case login(name: String, pass: String)
    case projectList(page:String)
    
}


extension ITService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://10.0.13.93/api/")!
    }
    
    public var path: String {
        switch self {
            
        case .login:
            return "Login"
        case .projectList:
            return "project/list"

            
        }
    }
    
    public var method: Moya.Method { return .post }
    public var parameters: [String : Any]? {
        
        switch self {
        case .login(let name, let pass):
            return ["name": name, "pass": pass]
        case .projectList(let page):
            return ["page":page]

            

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
