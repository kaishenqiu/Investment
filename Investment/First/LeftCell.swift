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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var oneModel = LeftModel(json:JSON.null) {
        didSet {
            title.text = oneModel.name
//            num.text = oneModel.accrual
            
            
            
        }
    }
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var tip: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
