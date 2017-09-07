//
//  ANRefreshHeader.swift
//  PigManager
//
//  Created by 邱仙凯 on 2017/5/24.
//  Copyright © 2017年 Much. All rights reserved.
//

import UIKit
import MJRefresh
class ANRefreshHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        self.isAutomaticallyChangeAlpha = true
        self.lastUpdatedTimeLabel.isHidden = true
        self.stateLabel.font = UIFont.systemFont(ofSize: 12)
        self.setTitle("刷新完成", for: .idle)
        self.setTitle("下拉刷新", for: .pulling)
        self.setTitle("正在刷新..", for: .refreshing)
    }
}
