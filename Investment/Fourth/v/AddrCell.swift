//
//  AddrCell.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/21.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddrCell: UITableViewCell {
    
    var delBlock:(() -> ())?
    
    @IBOutlet weak var mobileLab: UILabel!
    @IBOutlet weak var addrLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    var oneModel = AddrModel(json:JSON.null) {
        didSet {
            nameLab.text = oneModel.realname
            mobileLab.text = oneModel.mobile
            addrLab.text = oneModel.country! + oneModel.province! + oneModel.city! + oneModel.district! + oneModel.address!
            
            
        }
    }
    @IBAction func modifyAction(_ sender: Any) {
    }
    @IBAction func delAction(_ sender: Any) {
        self.delBlock!()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
