//
//  NetworkTool.swift
//  AlarmFireTest
//
//  Created by 寂惺 on 2018/7/8.
//  Copyright © 2018年 haha. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}


class NetworkTool{
    class func request(urlString: String , method : MethodType,params:[String:String]?=nil,
                       finishedCallback : @escaping (_ result:AnyObject) -> ()){
        //获取类型
        let httpMethod = method == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(urlString, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            //获取结果
            guard let jasonResult = response.result.value else{
                print(response.result.error ?? "response error")
                return
            }
            
            //将结果回调
            finishedCallback(jasonResult as AnyObject)
        }
    }
}
