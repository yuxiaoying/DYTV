//
//  RoomVo.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/9.
//  Copyright © 2018年 haha. All rights reserved.
//

import HandyJSON

struct RoomVo:HandyJSON{
    var room_id : Int!
    var room_name : String!
    var nickname : String!
    var cate_id : Int!
    var cate2_name : String!
    var room_src : String = "Img_default"
    var online_num : Int!
    var hn : Int!

}

struct RoomsDataVo:HandyJSON {
    var roomRule : Int?
    var msg :String?
    var list : [RoomVo]?
}

struct RoomJsonVo:HandyJSON {
    var error : Int?
    var msg : String!
    var data : RoomsDataVo?
}


