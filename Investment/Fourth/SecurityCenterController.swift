//
//  SecurityCenterController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class SecurityCenterController: UIViewController {

    
    var setPayPwdView:SetPayPwd!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func changePayPwd(_ sender: Any) {
        
        self.setPayPwdView = Bundle.main.loadNibNamed("SetPayPwd", owner: nil, options: nil)!.last as! SetPayPwd
        self.setPayPwdView.frame = UIApplication.shared.keyWindow!.frame
        
//        self.setPayPwdView.saveBlock = {str in
//            self.chooseBtn.setTitle(str, for: .normal)
//            
//        }
        UIApplication.shared.keyWindow!.addSubview(self.setPayPwdView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
