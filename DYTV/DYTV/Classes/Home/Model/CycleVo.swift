//
//  CycleVo.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/12.
//  Copyright © 2018年 haha. All rights reserved.
//

import Foundation
import HandyJSON

struct CycleVo: HandyJSON{
    var title : String!
    var pic_url : String!
    var room : CycleRoom!
}

struct CycleJson: HandyJSON{
    var error : Int!
    var data : [CycleVo]!
}

struct CycleRoom :HandyJSON{
    var room_id : Int!
    var room_src : String!
    var room_name : String!
    var online : String!
    var nickname : String!
    var url : String!
    var game_url: String!
    var game_name: String!
    var game_icon_url: String!
    var show_details: String!
    var owner_avatar: String!
}
