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
    var modifyBlock:(() -> ())?
    var defauBlock:((String) -> ())?
    
    var defau = false {
        didSet {
            if defau {
              self.defauBtn.setTitleColor(#colorLiteral(red: 0.9882352941, green: 0.337254902, blue: 0.1215686275, alpha: 1), for: .normal)
              self.defauBtn.setImage(#imageLiteral(resourceName: "adress_check"), for: .normal)
            } else {
                self.defauBtn.setTitleColor(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), for: .normal)
                self.defauBtn.setImage(#imageLiteral(resourceName: "adress_uncheck"), for: .normal)
            }
           
        }
    }
    
    @IBOutlet weak var defauBtn: UIButton!
    @IBOutlet weak var mobileLab: UILabel!
    @IBOutlet weak var addrLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    var oneModel = AddrModel(json:JSON.null) {
        didSet {
            nameLab.text = oneModel.realname
            mobileLab.text = oneModel.mobile
            addrLab.text = oneModel.country! + oneModel.province! + oneModel.city! + oneModel.district! + oneModel.address!
            defau = oneModel.defau == "0" ? false : true
            
            
        }
    }
    
    @IBAction func modifyAction(_ sender: Any) {
        self.modifyBlock!()
       
    }
    @IBAction func delAction(_ sender: Any) {
        self.delBlock!()
    }

    @IBAction func defauAction(_ sender: Any) {
        if self.defau {
         self.defauBlock!("0")
        } else {
         self.defauBlock!("1")
        }
        
//         self.defau =  !self.defau
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
