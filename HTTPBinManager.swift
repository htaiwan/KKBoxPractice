//
//  HTTPBinManager.swift
//  KK_Operation
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

// 7. 
protocol HTTPBinManagerDelegate {
    
    func HTTPBinManagerDidFail()
    func HTTPBinManagerDidCancel()
    func HTTPBinManagerDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage)
    func HTTPBinManagerUpdateProgress(progrss: Float)
    
}

class HTTPBinManager: NSObject,HTTPBinManagerOperationDelegate {
    
    var delegate: HTTPBinManagerDelegate?
    let operation = HTTPBinManagerOperation()
    
    // 2. 寫一個HTTPBinManager的singleton物件
    static let sharedInstance: HTTPBinManager = {
        let instance = HTTPBinManager()
        return instance
    }()
    
    // 3. 增加一個NSOperationQueue的成員變數
    let operationQueue = NSOperationQueue()
    
    // 6. 加入executeOperation
    func executeOperation() {
        operation.delegate = self
        operationQueue.addOperation(operation)
    }
    
    func cancelOperation() {
        operation.cancel()
    }
    
    // MARK: - HTTPBinManagerOperationDelegate
    
    // 7.
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
