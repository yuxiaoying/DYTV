//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/6.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
}

extension CollectionHeaderView{
    func reloadHeader(roomGroup:RoomGroupVo){
        titleLabel.text = roomGroup.headerName
        let iconName = roomGroup.headerIcon ?? "home_header_normal"
        iconImageView.image = UIImage(named:iconName)
    }
}
