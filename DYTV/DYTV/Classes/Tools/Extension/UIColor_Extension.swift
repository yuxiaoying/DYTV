//
//  UIColor_Extension.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/2.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:UInt32,g:UInt32,b:UInt32){
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }

}
