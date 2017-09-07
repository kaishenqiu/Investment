//
//  ANRefreshFooter.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/5/24.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit
import MJRefresh

class ANRefreshFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        self.isAutomaticallyHidden = true
        self.stateLabel.font = UIFont.systemFont(ofSize: 12)
        self.setTitle("没有更多数据了", for: .noMoreData)
    }

}
