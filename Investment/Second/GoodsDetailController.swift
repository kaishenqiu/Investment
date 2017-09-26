//
//  GoodsDetailController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/22.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class GoodsDetailController: UIViewController {
    
    var good_no = ""

    var chooseV:ChooseView!
    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var des: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        ANBaseNetWork.sharedInstance.networkForOriginalWithHeader(.goodsinfo(goods_no: good_no)) { (result) in
 
            
            guard let jsonData = result else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let flag = jsonData["code"].stringValue
            guard flag == "200" else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let one = GoodsModel(json: jsonData["data"])
            self.goods_name.text = one.goodsName!
            
            
            
        
            do{
                let attrStr = try NSAttributedString(data: (one.descriptionValue?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                
                self.des.attributedText = attrStr
            }catch let error as NSError {
                print(error.localizedDescription)
            }
            
            print(jsonData["data"])
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseAction(_ sender: Any) {
        
        self.chooseV = Bundle.main.loadNibNamed("ChooseView", owner: nil, options: nil)!.last as! ChooseView
        self.chooseV.frame = UIApplication.shared.keyWindow!.frame

        self.chooseV.saveBlock = {str in
            self.chooseBtn.setTitle(str, for: .normal)
            
        }
        UIApplication.shared.keyWindow!.addSubview(self.chooseV)
        
        
    }

    @IBAction func confirmAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tochooseview", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tochooseview" {
//            let sd = sender as! IndexPath
//            let dVC = segue.destination as! ChooseViewController
//       
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
