//
//  ColumnVo.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/9.
//  Copyright © 2018年 haha. All rights reserved.
//

import HandyJSON

struct ParentColumnsJsonVo:HandyJSON {
    var error : Int?
    var data : [ParentColumnVo]?
}

struct ParentColumnVo:HandyJSON {
    var cate_id : String?
    var cate_name : String?
    var short_name : String?
}
