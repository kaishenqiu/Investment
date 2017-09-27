//
//  GoodsDetailController.swift
//  Investment
//
//  Created by 邱仙凯 on 2017/9/22.
//  Copyright © 2017年 kaishen. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
class GoodsDetailController: UIViewController,UIWebViewDelegate {
    
    var good_no = ""

    var chooseV:ChooseView!
    var groupArray = [String]()
    var partArray = [PartModel]()
    @IBOutlet weak var goods_name: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var scrollView: UIScrollView!


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
            
            let properties = jsonData["data"]["properties"].arrayValue
            for item in properties {
                let one = PartModel(json:item)
                self.partArray.append(one)
            }
            
            print(self.partArray)
            
           let properties_group = jsonData["data"]["properties_group"].arrayValue
            for dic in properties_group {
                if dic["group_name"] == "部位" {
                    self.groupArray = dic["list"].arrayObject as! [String]
                
                }
            }
            print(self.groupArray)
            
            
            self.webView.loadHTMLString(one.descriptionValue!, baseURL: nil)
            self.webView.delegate = self
      
      
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        webView.stringByEvaluatingJavaScript(from: "var script = document.createElement('script');script.type = 'text/javascript';script.text = \"function ResizeImages() { var myimg,oldwidth;var maxwidth = 375;for(i=0;i <document.images.length;i++){myimg = document.images[i];if(myimg.width > maxwidth){oldwidth = myimg.width;myimg.width =360;}}}\";document.getElementsByTagName('head')[0].appendChild(script);")
        
        webView.stringByEvaluatingJavaScript(from: "ResizeImages();");
        
        let actualSize = webView.sizeThatFits(CGSize.zero)
        var newFrame = webView.frame
        newFrame.size.height = actualSize.height
        webView.frame = newFrame
        scrollView.contentSize = CGSize(width:newFrame.size.width,height:newFrame.size.height + 100)
        
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func confirmAction(_ sender: Any) {
        
        self.chooseV = Bundle.main.loadNibNamed("ChooseView", owner: nil, options: nil)!.last as! ChooseView
        
        self.chooseV.propertiesArray = self.partArray
        self.chooseV.ddd = self.groupArray
        self.chooseV.frame = UIApplication.shared.keyWindow!.frame
        
        self.chooseV.saveBlock = {name,pno,number,wxprice in
            
            var one = PartModel(json:JSON.null)
            one.name = name
            one.pno = pno
            one.number = number
            one.wxprice = wxprice
            
            self.performSegue(withIdentifier: "tochooseview", sender: one)
            
        }
        UIApplication.shared.keyWindow!.addSubview(self.chooseV)
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tochooseview" {
            let sd = sender as! PartModel
            let dVC = segue.destination as! ChooseViewController
            dVC.oneModel = sd

            
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
