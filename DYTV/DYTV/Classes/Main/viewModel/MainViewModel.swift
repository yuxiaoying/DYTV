//
//  MainViewModel.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/9.
//  Copyright © 2018年 haha. All rights reserved.
//

import HandyJSON

class MainViewModel{
    
}

//获取频道结构
extension MainViewModel{
    func requestParentColum() ->[ParentColumnVo]{
        //请求所有父频道http://capi.douyucdn.cn/api/v1/getColumnList
        var returnColumns = [ParentColumnVo]()
        NetworkTool.request(urlString: "http://capi.douyucdn.cn/api/v1/getColumnList", method: MethodType.GET) { result in
            if let jsonResponse = JSONDeserializer<ParentColumnsJsonVo>.deserializeFrom(json: result){
                returnColumns = jsonResponse.data!
            }
        }
        return returnColumns
    }
    
    func requestChildColumn(parentShortName:String){
        
    }
}
