//
//  SecondCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondCell: UITableViewCell {
    
    
    var oneModel = GoodsModel(json:JSON.null) {
        didSet {
            titleLab.text = oneModel.goodsName
 
            
            
            
        }
    }
    @IBOutlet weak var titleLab: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
