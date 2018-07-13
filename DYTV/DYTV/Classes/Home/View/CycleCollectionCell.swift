//
//  CycleCollectionCell.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/12.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

}

extension CycleCollectionCell{
    func reloadCell(cycleVo:CycleVo){
        self.imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: cycleVo.pic_url)!))
        self.titleLabel.text = cycleVo.title
    }
}
