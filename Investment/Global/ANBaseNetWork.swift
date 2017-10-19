//
//  ANBaseNetWork.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/5/6.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import SVProgressHUD
class ANBaseNetWork: NSObject {
    

    static let sharedInstance = ANBaseNetWork()
    private override init() {}

    let provider = MoyaProvider<ITService>()
    
    // MARK: - 带请求头
    let providerWithHeader = MoyaProvider(endpointClosure: { (target: ITService) -> Endpoint<ITService> in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint = Endpoint<ITService>(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)
        return endpoint.adding(newHTTPHeaderFields: ["Accept" : "text/html", "Authorization" :UserDefaults.standard.value(forKey: TOKENAuthorization) as! String])
    })
    
    
    // MARK: - 请求网络获取操作结果 成或败

    func networkForBool(_ target: ITService, successHandle: ((Bool) -> Void)?, errorHandle: ((String) -> Void)?) {

        SVProgressHUD.show()
        provider.request(target) { result in
            SVProgressHUD.dismiss()
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    if data["code"].stringValue == "200" {

                            if let handle = successHandle {
                                handle(true)
                            }
                    } else {

                        if let handle = errorHandle {
                            handle(data["info"].stringValue)
                        }

                    }
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }

    }
    
    // MARK: - 请求网络获取操作结果 成或败  带请求头
    
    func networkForBoolWithHeader(_ target: ITService, successHandle: ((Bool) -> Void)?, errorHandle: ((String) -> Void)?) {
        
        SVProgressHUD.show()
        providerWithHeader.request(target) { result in
            SVProgressHUD.dismiss()
            ANLog(result)
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    print(data)
                    if data["code"].stringValue == "200" {
                        
                        if let handle = successHandle {
                            handle(true)
                        }
                    } else {
                        
                        if let handle = errorHandle {
                            handle(data["msg"].stringValue)
                        }
                        
                    }
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }
        
    }

    // MARK: - 请求网络获取列表

    func networkForList(_ target: ITService, successHandle: (([JSON]) -> Void)?, errorHandle: ((String) -> Void)?) {

        SVProgressHUD.show()
        provider.request(target) { result in
            SVProgressHUD.dismiss()

            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    if data["code"].stringValue == "200" {
                        if let json_array = data["data"].array {
                            if let handle = successHandle {
                                handle(json_array)
                            }
                        }
                    } else {
                        if let handle = errorHandle {
                            handle(data["msg"].stringValue)
                        }
                    }
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }

    }
    
    
    // MARK: - 请求网络获取列表 无加载提示
    
    func networkForListNOHUD(_ target: ITService, successHandle: (([JSON]) -> Void)?, errorHandle: ((String) -> Void)?) {
        
        provider.request(target) { result in

            
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    
                    if data["code"].stringValue == "200" {
                        if let json_array = data["data"].array {
                            if let handle = successHandle {
                                handle(json_array)
                            }
                        }
                    } else {
                        if let handle = errorHandle {
                            handle(data["msg"].stringValue)
                        }
                    }
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }
        
    }
    
    // MARK: - 请求网络获取列表 无加载提示 带请求头
    
    func networkForListNOHUDWithHeader(_ target: ITService, successHandle: (([JSON]) -> Void)?, errorHandle: ((String) -> Void)?) {
 
        providerWithHeader.request(target) { result in
            
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    
                    if data["code"].stringValue == "200" {
                        if let json_array = data["data"].array {
                            if let handle = successHandle {
                                handle(json_array)
                            }
                        }
                    } else {
                        if let handle = errorHandle {
                            handle(data["msg"].stringValue)
                        }
                    }
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }
        
    }
    

    // MARK: - 请求网络获取原始结果

    func networkForOriginal(_ target: ITService, resultHandle: ((JSON?) -> Void)?) {

        SVProgressHUD.show()
        provider.request(target) { result in
            SVProgressHUD.dismiss()
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)

                            if let handle = resultHandle {
                                handle(data)
                            }

                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }

    }

    // MARK: - 请求网络获取原始结果  没有加载提示

    func networkForOriginalNoHUD(_ target: ITService, resultHandle: ((JSON?) -> Void)?) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)

                    if let handle = resultHandle {
                        handle(data)
                    }

                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }

    }
    
    // MARK: - 请求网络获取原始结果  没有加载提示  带请求头
    
    func networkForOriginalWithHeader(_ target: ITService, resultHandle: ((JSON?) -> Void)?) {
        SVProgressHUD.show()
        providerWithHeader.request(target) { result in
            SVProgressHUD.dismiss()
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let data = JSON(json)
                    
                    if let handle = resultHandle {
                        handle(data)
                    }
                    
                } catch {
                    ANLog("❌: Network connection is successful, but mapJSON error")
                }
            case let .failure(error):
                ANLog(error.errorDescription)
            }
        }
        
    }

}
