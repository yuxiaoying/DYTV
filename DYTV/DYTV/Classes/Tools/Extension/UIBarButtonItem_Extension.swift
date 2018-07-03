//
//  UIBarButtonItem_Extension.swift
//  DYTV
//
//  Created by 寂惺 on 2018/6/28.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //类方法
    class func createItem(imageName: String,hightedImageName: String,imageWidth:CGFloat,imageHeight:CGFloat) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightedImageName), for: .highlighted)
        btn.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        return UIBarButtonItem(customView: btn)
    }
    //遍历构造函数
    convenience init(imageName: String,hightedImageName: String,imageWidth:CGFloat,imageHeight:CGFloat){
        let btn = UIButton()
        if imageName != ""{
             btn.setImage(UIImage(named: imageName), for: .normal)
        }
        if hightedImageName != ""{
            btn.setImage(UIImage(named: hightedImageName), for: .highlighted)
        }
        if(imageWidth != 0 && imageHeight != 0){
            btn.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        }else{
            btn.sizeToFit();
        }
        self.init(customView: btn)
    }
}
