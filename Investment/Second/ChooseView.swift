//
//  ChooseView.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChooseView: UIView {
    
    var saveBlock:((String,String,Int,String) -> ())?

    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var heiBg: UIImageView!
    @IBOutlet weak var partbgView: UIView!
    let spaceC:CGFloat = 10
    let heightC:CGFloat = 30
    let rowCount:CGFloat = 4
    
    
    var countNum = 1
    var chooseName = ""
    var choosePno = ""
    var wxprice = ""
    var tempButton:JWCountButton!
    @IBOutlet weak var numLab: UILabel!
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
 
    
    var propertiesArray = [PartModel]()
    var ddd = [String]() {
        didSet {
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
                
                let one = self.propertiesArray[i]
                let stock = Int(one.stock!)
                if stock! < 1 {
                    button.isUserInteractionEnabled = false
                    button.setTitleColor( #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
                    
                }
                
                self.partbgView.addSubview(button)
                
                
            }
        }
    }
 
    
    func cancel(){
        self.removeFromSuperview()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.removeFromSuperview()
//    }
    
    override func awakeFromNib() {
        let viewG = UITapGestureRecognizer(target: self, action: #selector(cancel))
        heiBg.addGestureRecognizer(viewG)
        
        tempButton = JWCountButton(frame:CGRect(x:0,y:0,width:100,height:30))
        tempButton.shakeAnimation = true
        tempButton.maxValue = 1
        tempButton.minValue = 1
        tempButton.increaseImage = UIImage(named:"coupon_increase")
        tempButton.decreaseImage = UIImage(named:"coupon_decrease")
        self.countView.addSubview(tempButton)
        tempButton.valueChanged = { number, isIncrease in
            let aa = isIncrease ? "加":"减"
            print( aa + "\(number)")
            self.countNum = number
        }
  
  
 
    }
    func buttonAction(sender:UIButton?) {
        
        tempButton.currentNumber = 1
        
 
        if selectedBtn == nil {
           selectedBtn = sender
           selectedBtn?.layer.borderColor = GlobalColor.cgColor
        } else {
           selectedBtn?.layer.borderColor = UIColor.lightGray.cgColor
           selectedBtn = sender
           selectedBtn?.layer.borderColor = GlobalColor.cgColor
        }
        let one = self.propertiesArray[(sender?.tag)!]
        self.storageLab.text = one.name! + " 库存：" + one.stock! + " 单价: \(one.wxprice!)"
        self.chooseLab.text = "已选择：" + ddd[(sender?.tag)!]
        tempButton.maxValue = Int(one.stock!)!
        countNum = tempButton.currentNumber
        chooseName = ddd[(sender?.tag)!]
        choosePno = one.pno!
        wxprice = one.wxprice!
        
 
        
    }
    
    @IBAction func confirmAtion(_ sender: Any) {
        if chooseName == "" {
            SVProgressHUD.showInfo(withStatus: "请选择部位")
            return
        }

        saveBlock!(chooseName,choosePno,countNum,wxprice)
        self.removeFromSuperview()
        
    }

}
