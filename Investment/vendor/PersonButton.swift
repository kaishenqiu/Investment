//
//  PersonButton.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/19.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class PersonButton: UIButton {

    override func awakeFromNib() {
//        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
      
    // 设置imageView
    imageView?.frame = CGRect(x: 35 , y: 9, width: 32, height: 32)
    // 设置title
    titleLabel?.frame = CGRect(x: self.frame.width/2 - 10, y: 0, width: self.frame.width/2, height: self.frame.height)

        
  
//                self.imageView?.st_x = self.st_x + 30
//                self.imageView?.st_centerY = self.st_centerY
//                self.imageView?.st_width = 35
//                self.imageView?.st_height = 35
//        ////
        //        self.titleLabel?.st_x = 0
        //        self.titleLabel?.st_bottom = self.st_bottom
        //        self.titleLabel?.st_width = self.st_width
    }

}
