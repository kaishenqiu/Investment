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
}


extension ITService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://10.0.13.93/OkApiDoc/")!
    }
    
    public var path: String {
        switch self {
            
        case .login:
            return "/Login"

            
        }
    }
    
    public var method: Moya.Method { return .get }
    public var parameters: [String : Any]? {
        
        switch self {
        case .login(let name, let pass):
            return ["name": name, "pass": pass]
            

            

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
