//
//  ChooseView.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class ChooseView: UIView {
    
    var saveBlock:((String) -> ())?

    @IBOutlet weak var partbgView: UIView!
    let spaceC:CGFloat = 10
    let heightC:CGFloat = 30
    let rowCount:CGFloat = 4
    
    @IBOutlet weak var storageLab: UILabel!
    @IBOutlet weak var chooseLab: UILabel!
    var selectedBtn:UIButton?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 
    var ddd = ["后腿","猪腿","前腿","猪头","猪尾巴","猪大肠","猪舌","猪腰","猪肺","猪大排","猪心","猪骨"]
    var aaa = ["3","5","7","23","11","45","22","8","9","6","5","2"]
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    override func awakeFromNib() {
        
        let widthC = (self.partbgView.st_width - spaceC * (rowCount - 1 )) / rowCount
        
        for i in 0..<ddd.count {
            let c = CGFloat(i)
            
            
            let button = UIButton(frame:CGRect(x:(widthC + spaceC) * (c.truncatingRemainder(dividingBy: rowCount)) ,y:CGFloat((i/Int(rowCount))) * (spaceC + heightC),width:widthC,height:heightC))
            button.setTitle(ddd[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.layer.masksToBounds = true
            button.setTitleColor( #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
            button.tag = i
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            self.partbgView.addSubview(button)
          
       
        }
 
        
    }
    func buttonAction(sender:UIButton?) {

        if selectedBtn == nil {
           selectedBtn = sender
           selectedBtn?.layer.borderColor = GlobalColor.cgColor
        } else {
           selectedBtn?.layer.borderColor = UIColor.lightGray.cgColor
           selectedBtn = sender
           selectedBtn?.layer.borderColor = GlobalColor.cgColor
        }
        self.storageLab.text = "库存：" + aaa[(sender?.tag)!]
        self.chooseLab.text = "已选择：" + ddd[(sender?.tag)!] + "   数量：1"
        
 
        
    }
    
    @IBAction func confirmAtion(_ sender: Any) {
        
        saveBlock!(self.chooseLab.text!)
        self.removeFromSuperview()
        
    }

}
