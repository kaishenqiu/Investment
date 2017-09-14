//
//  FourthController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/6.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class FourthController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self .navigationController?.navigationBar.setBackgroundImage(getImageWithColor(color: GlobalColor, size: CGSize(width:1,height:1)), for: .any, barMetrics: .default)
        self .navigationController?.navigationBar.shadowImage = UIImage()
        self .navigationController?.navigationBar.isTranslucent = false
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func zichanAction(_ sender: Any) {
        
        guard (UserDefaults.standard.value(forKey: TOKEN) != nil) else {
            let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController()!
            self.present(vc, animated: true, completion: nil)
            return
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
