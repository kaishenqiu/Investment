//
//  LeftCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/7.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class LeftCell: UITableViewCell {

    @IBOutlet weak var minMoney: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var oneModel = LeftModel(json:JSON.null) {
        didSet {
            title.text = oneModel.name
            num.text = "\(oneModel.accrual!)%"
            term.text = "期限\(oneModel.termDay!)天"
            
            
            let aa = JSON(oneModel.properties!)
            let bb = aa["voucher"] == "" ? "暂无" : aa["voucher"]
            print(aa["voucher"])
            
            danbao.text = "由\(bb)担保\(aa["voucher_money"])"
            minMoney.text = "最小投资金额\(aa["min_money"])"
        
        
//            let model = dataArray[indexPath.section]
//            let one = model.goodsitems![0]
//            cell.titleLab.text = one["goods_name"] as? String
//            cell.priceLab.text = "单价：\(one["price"]!)"
//            cell.numLab.text = "数量：\(one["number"]!)"
//            
            
        }
    }
    
    @IBOutlet weak var danbao: UILabel!
    @IBOutlet weak var term: UILabel!
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var tip: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
