//
//  MyInvestmentCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/14.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyInvestmentCell: UITableViewCell {
    
    var oneModel = InvestModel(json:JSON.null) {
        didSet {
            order_no.text = "订单号：" + oneModel.orderNo!
            project_name.text = "关联项目：" + oneModel.projectName!
            bitTime.text = "投资时间：" + oneModel.bidTime!
            endDate.text = "回款时间：" + oneModel.endDate!
            money.text = oneModel.money!
            expect_money.text = oneModel.expectMoney!
            
            
            
        }
    }

    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var expect_money: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var bitTime: UILabel!
    @IBOutlet weak var order_no: UILabel!
    @IBOutlet weak var project_name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
