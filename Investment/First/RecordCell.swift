//
//  RecordCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/16.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordCell: UITableViewCell {
    
    var oneModel = RecordModel(json:JSON.null) {
        didSet {
            telLab.text = oneModel.usreNm
            moneyLab.text = oneModel.money
            timeLab.text = oneModel.bidTime
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var telLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
