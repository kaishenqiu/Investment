//
//  FourthController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class FourthController: UIViewController {

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
        
        self .navigationController?.navigationBar.setBackgroundImage(getImageWithColor(color: #colorLiteral(red: 0.9294117647, green: 0.2352941176, blue: 0.2196078431, alpha: 1), size: CGSize(width:1,height:1)), for: .any, barMetrics: .default)
        self .navigationController?.navigationBar.shadowImage = UIImage()
        self .navigationController?.navigationBar.isTranslucent = false

        moneyLab.text = UserDefaults.standard.value(forKey: MONEY) as! String!
    
    
    
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
