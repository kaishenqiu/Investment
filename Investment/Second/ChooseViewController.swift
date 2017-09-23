//
//  ChooseViewController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/23.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewG = UITapGestureRecognizer(target: self, action: #selector(addrAction))
        addrView.addGestureRecognizer(viewG)

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var addrView: UIView!
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addrAction() {
        
        let view = UIStoryboard(name: "Fourth", bundle: Bundle.main).instantiateViewController(withIdentifier: "addresslist")
        self.navigationController?.pushViewController(view, animated: true)
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
