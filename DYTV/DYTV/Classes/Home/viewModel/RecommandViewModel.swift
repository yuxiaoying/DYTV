//
//  HomeViewModel.swift
//  DYTV
//
//  Created by 寂惺 on 2018/7/8.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
import HandyJSON

class RecommandViewModel{
    var allRoomGroups = [RoomGroupVo]()
}


//发送网络请求
extension RecommandViewModel{
    func requestData(finishedCallBack:@escaping ()->()){
        allRoomGroups.removeAll()
        var hotRooms = [RoomVo]()
        var prettyRooms = [RoomVo]()
        var hotRoomGroup = RoomGroupVo()
        var prettyRoomGroup = RoomGroupVo()
        var otherRoomGroups = [RoomGroupVo]()
        let dGroup = DispatchGroup()
        //请求热门
        dGroup.enter()
        NetworkTool.request(urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/0/20/ios?client_sys=ios", method: MethodType.GET) { result in
            
            if let jsonResponse = JSONDeserializer<RoomJsonVo>.deserializeFrom(json: result){
                guard let roomVos:[RoomVo] = jsonResponse.data?.list else{return}
                for i in 0...7{
                    hotRooms.append(roomVos[i])
                }
                hotRoomGroup.headerName = "热门"
                hotRoomGroup.headerIcon = "home_header_hot"
                hotRoomGroup.roomList = hotRooms
            }
            print(hotRooms.count)
            dGroup.leave()
        }
        
        //请求颜值/炉石传说:https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_2/0/20/ios?client_sys=ios
        dGroup.enter()
        NetworkTool.request(urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_2/0/20/ios?client_sys=ios", method: MethodType.GET) { result in

            if let jsonResponse = JSONDeserializer<RoomJsonVo>.deserializeFrom(json: result){
                guard let roomVos:[RoomVo] = jsonResponse.data?.list else{return}
                for i in 0...3{
                    prettyRooms.append(roomVos[i])
                }
                prettyRoomGroup.headerName = "炉石传说"
                prettyRoomGroup.headerIcon = "home_header_phone"
                prettyRoomGroup.roomList = prettyRooms
            }
            dGroup.leave()
        }
        
        //请求英雄联盟 https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_1/0/20/ios?client_sys=ios
        
        dGroup.enter()
        NetworkTool.request(urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_1/0/20/ios?client_sys=ios", method: MethodType.GET) { result in
            
            if let jsonResponse = JSONDeserializer<RoomJsonVo>.deserializeFrom(json: result){
                guard let roomVos:[RoomVo] = jsonResponse.data?.list else{return}
                for i in 0...4{
                    var lolRoomGroup = RoomGroupVo()
                    var lolRooms = [RoomVo]()
                    for j in 0...3{
                        lolRooms.append(roomVos[i*4+j])
                    }
                    lolRoomGroup.roomList = lolRooms
                    lolRoomGroup.headerName = "英雄联盟"
                    lolRoomGroup.headerIcon = "home_header_normal"
                    otherRoomGroups.append(lolRoomGroup)
                }
            }
            dGroup.leave()
        }
        
        //王者荣耀
        dGroup.enter()
        NetworkTool.request(urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_181/0/20/ios?client_sys=ios", method: MethodType.GET) { result in
            
            if let jsonResponse = JSONDeserializer<RoomJsonVo>.deserializeFrom(json: result){
                guard let roomVos:[RoomVo] = jsonResponse.data?.list else{return}
                for i in 0...4{
                    var wzRoomGroup = RoomGroupVo()
                    var wzRooms = [RoomVo]()
                    for j in 0...3{
                        wzRooms.append(roomVos[i*4+j])
                    }
                    wzRoomGroup.roomList = wzRooms
                    wzRoomGroup.headerName = "王者荣耀"
                    wzRoomGroup.headerIcon = "home_header_normal"
                    otherRoomGroups.append(wzRoomGroup)
                }
            }
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            print(self.allRoomGroups.count)
            self.allRoomGroups.append(hotRoomGroup)
            self.allRoomGroups.append(prettyRoomGroup)
            for otherHomeGroup in otherRoomGroups{
                self.allRoomGroups.append(otherHomeGroup)
            }
            print(self.allRoomGroups.count)
            finishedCallBack()
        }
        
        
    }
}
