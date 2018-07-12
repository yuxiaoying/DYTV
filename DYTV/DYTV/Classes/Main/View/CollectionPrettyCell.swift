//
//  CollectionPrettyCell.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/6.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    //定义控件
    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var onlineNumBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
}


extension CollectionPrettyCell{
    func reloadCell(room:RoomVo){
        self.titleLabel.text = room.room_name
        self.cityBtn.setTitle(room.cate2_name, for: UIControlState.normal)
        var onlineStr = ""
        if room.online_num >= 10000{
            onlineStr = "\(Int(room.online_num/10000))万在线"
        }else{
            onlineStr = "\(Int(room.online_num))在线"
        }
        self.onlineNumBtn.setTitle(onlineStr, for: .normal)
        self.srcImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: room.room_src)!))
    }
}

