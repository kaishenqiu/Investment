//
//  STMyAnnotationView.swift
//  BuildingManager
//
//  Created by 邱仙凯 on 2017/3/29.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit



 var annoHeight = 35
 var annoWidth = 30




/*
 * 楼宇级AnnotationView
 */
class STMyAnnotationView : BMKPinAnnotationView {
   
    
    override init(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.bounds = CGRect(x: 0, y: 0, width: annoWidth, height: annoHeight)
 
 
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
