//
//  CardCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/14.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class CardCell: UITableViewCell {
    
    
    var oneModel = CardModel(json:JSON.null) {
        didSet {
        titleLab.text = oneModel.bankNm
        numLab.text = oneModel.bankNo
            
            
        }
    }
    @IBOutlet weak var numLab: UILabel!

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
