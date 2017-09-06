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


// MARK: - 获取数据字典
public func getDataDictionary() {
    

    
}
