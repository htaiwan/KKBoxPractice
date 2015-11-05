//
//  ApiManager.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/4/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit
import AFNetworking
import Bolts

class ApiManager: NSObject {
    
    let baseURL = "http://httpbin.org"
    let manager =  AFHTTPSessionManager()
    
    func fetchGetResponse() -> BFTask {
        
        let source = BFTaskCompletionSource()
        let url = "\(baseURL)/get"
        
        manager.GET(url, parameters: nil, success: { (task, respondObject) -> Void in
            let dic = respondObject as! NSDictionary
            source.setResult(dic)
            
            }) { (task, error) -> Void in
                source.setError(error)
        }
        
        return source.task
    }
    
    func postCustomerName(name: String) -> BFTask {
        
        let source = BFTaskCompletionSource()
        let url = "\(baseURL)/post"
        
        let parameters = NSMutableDictionary()
        parameters.setObject(name, forKey: "custname")
        
        manager.POST(url, parameters: parameters, success: { (task, respondObject) -> Void in
            let dic = respondObject as! NSDictionary
            source.setResult(dic)
            
            }) { (task, error) -> Void in
                source.setError(error)

        }
        
        return source.task
    }
    
    func fetchImage() -> BFTask {
        let source = BFTaskCompletionSource()
        let url = "\(baseURL)/image/png"
        
        manager.responseSerializer = AFImageResponseSerializer()
        manager.GET(url, parameters: nil, success: { (task, respondObject) -> Void in
            let image = respondObject as! UIImage
            source.setResult(image)
            
            }) { (task, error) -> Void in
                source.setError(error)
        }
        
        return source.task
    }

}
