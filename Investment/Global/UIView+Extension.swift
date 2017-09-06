//
//  UIView+Extension.swift
//  BuildingManager
//
//  Created by 浮生若梦 on 2017/3/21.
//  Copyright © 2017年 SMART. All rights reserved.
//

import UIKit

extension UIView {
    /// X值
    var st_x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }

    }
    
    /// Y值
    var st_y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }

    }
    
    /// 中心点X
    var st_centerX: CGFloat {
        get{
            return self.center.x
        }
        set{
            var r = self.center
            r.x = newValue
            self.center = r
        }

    }
    
    /// 中心点Y
    var st_centerY: CGFloat {
        get{
            return self.center.y
        }
        set{
            var r = self.center
            r.y = newValue
            self.center = r
        }

    }
    
    /// 宽度
    var st_width: CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame.size
            r.width = newValue
            self.frame.size = r
        }

    }
    
    /// 高度
    var st_height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame.size
            r.height = newValue
            self.frame.size = r
        }
    }
    
    /// 尺寸
    var st_size: CGSize {
        get{
            return self.frame.size
        }
        set{
            var r = self.frame.size
            r = newValue
            self.frame.size = r
        }

    }
    
    /// 底部
    var st_bottom: CGFloat {
        get{
            let frame = self.frame
            return frame.maxY
        }
        set{
            let frame = self.frame
            let bottom = frame.maxY
            var r = bottom
            r = newValue
            self.frame.origin.y = r - self.frame.size.height
        }
        
    }
    
    /// 坐标
    var st_point: CGPoint {
        get{
            return self.frame.origin
        }
        set{
            var r = self.frame.origin
            r = newValue
            self.frame.origin = r
        }

    }
    
    public func viewFromXib() -> UIView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.last! as! UIView
    }
}
