//
//  HTTPBinManager.swift
//  KK_Operation
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

protocol HTTPBinManagerDelegate {
    
    func HTTPBinManagerDidFail()
    func HTTPBinManagerDidCancel()
    func HTTPBinManagerDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage)
    func HTTPBinManagerUpdateProgress(progrss: Float)
    
}

class HTTPBinManager: NSObject,HTTPBinManagerOperationDelegate {
    
    // 7. HTTPBinManager 也有自己的 delegate
    var delegate: HTTPBinManagerDelegate?
    
    let operation = HTTPBinManagerOperation()
    
    // 2. 寫一個叫做 HTTPBinManager 的 singleton 物件。
    static let sharedInstance: HTTPBinManager = {
        let instance = HTTPBinManager()
        return instance
    }()
    
    // 3. 在這個 HTTPBinManager 中，增加一個 NSOperationQueue 的成員變數
    let operationQueue = NSOperationQueue()
    
    // 6. HTTPBinManager 要加入一個叫做 executeOperation 的 method，這個 method 首先會清除 operation queue 裡頭所有的 operation，然後加入新的 HTTPBinManagerOperation。
    func executeOperation() {
        operationQueue.cancelAllOperations()
        
        // 7. HTTPBinManagerOperation 的 delegate 是 HTTPBinManager。
        operation.delegate = self
        operationQueue.addOperation(operation)
    }
    
    func cancelOperation() {
        operation.cancel()
    }
    
    // MARK: - HTTPBinManagerOperationDelegate
    
    // 7. 在 HTTPBinManagerOperation 成功抓取資料、發生錯誤的時候，HTTPBinManager 也會將這些事情告訴自己的 delegate。
    func HTTPBinManagerOperationDidFail() {
        self.delegate?.HTTPBinManagerDidFail()
    }
    
    func HTTPBinManagerOperationDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage) {
        self.delegate?.HTTPBinManagerDidSuccess(dic1, dic2: dic2, image: image)
    }
    
    func HTTPBinManagerOperationUpdateProgress(progrss: Float) {
        self.delegate?.HTTPBinManagerUpdateProgress(progrss)
    }
    
    func HTTPBinManagerOperationDidCancel() {
        self.delegate?.HTTPBinManagerDidCancel()
    }



}
