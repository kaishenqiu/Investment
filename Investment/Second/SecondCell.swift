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
            let url = URL(string: "http://10.0.13.93/\(oneModel.goodsImg!)")
            img.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "图片占位"))
            
        }
    }
    @IBOutlet weak var img: UIImageView!
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
