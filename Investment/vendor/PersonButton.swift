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
        self.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: self.st_width * 0.3)
        self.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        //        self.imageView?.st_centerX = self.st_centerX
        ////        self.imageView?.st_y = self.st_y + 5
        //        self.imageView?.st_width = self.st_width * 0.5
        //        self.imageView?.st_height = self.st_height * 0.4
        ////
        //        self.titleLabel?.st_x = 0
        //        self.titleLabel?.st_bottom = self.st_bottom
        //        self.titleLabel?.st_width = self.st_width
    }

}
