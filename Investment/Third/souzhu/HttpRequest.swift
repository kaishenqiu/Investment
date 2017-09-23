//
//  HttpRequest.swift
//  AWPigSearch
//
//  Created by Much on 15/10/14.
//  Copyright © 2015年 PonyMuch. All rights reserved.
//

import Foundation
import SwiftyJSON
import SVProgressHUD

class HttpRequest {
    
    typealias result_block_type  = (_ json_result: JSON) -> Void
    
    static var result_block : result_block_type!
    
    static let request_url = "http://app.zhuok.com.cn/szgl"
    static let tencent_url = "http://apis.map.qq.com/ws/district/v1"
    
    
 
    
    ///根据猪场ID获取展示数据
    static func http_request_getOpenPig(session_key session_key: String, zc_id: String, result_block: result_block_type) {
        
//        SVProgressHUD.show(withStatus: "正在搜索")
//        
//        self.result_block = result_block
//        
//        let request_url_method = request_url + "/map/getOpenPig"
//        
//        let url =  NSURL(string: request_url_method.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet(charactersInString: request_url_method))!)
//        
//        let url_request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 10)
//        
//        url_request.HTTPMethod = "POST"
//        
//        url_request.HTTPBody = "session_key=\(session_key)&zc_id=\(zc_id)".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        NSURLConnection.sendAsynchronousRequest(url_request, queue: NSOperationQueue()) { (response, data, error) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                SVProgressHUD.dismiss()
//                if data != nil{
//                    let result = JSON(data: data!)
//                    self.result_block!(json_result: result)
//                }
//                else{
////                    self.result_block!(json_result: nil)
//                    print(error?.debugDescription)
//                }
//              
//            })
//        }
        
    }
    
}

