//
//  OrderCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/26.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
