//
//  FourthController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD

class FourthController: UIViewController {

    @IBOutlet weak var availableLab: UILabel!
    @IBOutlet weak var totalLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        
        guard (UserDefaults.standard.value(forKey: TOKEN) != nil) else {
            
            let tabbar = UIApplication.shared.keyWindow?.rootViewController as! BaseTabbarController
            tabbar.selectedIndex = 0
            return
        }
        self .navigationController?.navigationBar.shadowImage = UIImage()
        self .navigationController?.navigationBar.isTranslucent = false
        
        self .navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "qqq"), for: .any, barMetrics: .default)
     

        
        
        
        
        
        
        // Do any additional setup after loading the view.
        ANBaseNetWork.sharedInstance.networkForOriginalWithHeader(.userassert) { (result) in
            
            
            guard let jsonData = result else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
            let flag = jsonData["code"].stringValue
            guard flag == "200" else {
                SVProgressHUD.showInfo(withStatus: "请求失败")
                return
            }
        
            self.moneyLab.text = jsonData["data"]["interest"].stringValue
            self.totalLab.text = "\(jsonData["data"]["balance"].intValue + jsonData["data"]["balance_fund"].intValue)"
            self.availableLab.text = jsonData["data"]["balance"].stringValue
      

            
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
