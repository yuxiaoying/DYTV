//
//  CollectionNormalCell.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/6.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

   //定义控件
    @IBOutlet weak var liveIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var onlineNumBtn: UIButton!
}

extension CollectionNormalCell{
    func reloadCell(room:RoomVo){
        self.liveIconImageView.image = UIImage(named: "home_live_cate_normal")
        self.titleLabel.text = room.room_name
        self.title2Label.text = room.nickname
        var onlineStr = ""
        if room.online_num >= 10000{
            onlineStr = "\(Int(room.online_num/10000))万在线"
        }else{
            onlineStr = "\(Int(room.online_num))在线"
        }
        self.onlineNumBtn.setTitle(onlineStr, for: .normal)
        srcImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: room.room_src)!))
    }
}
