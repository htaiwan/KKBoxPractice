//
//  HTTPBinManagerOperation.swift
//  KK_Operation
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

protocol HTTPBinManagerOperationDelegate {

    func HTTPBinManagerOperationDidFail()
    func HTTPBinManagerOperationDidCancel()
    func HTTPBinManagerOperationDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage)
    func HTTPBinManagerOperationUpdateProgress(progrss: Float)

}

// 4. 寫一個HTTPBinManagerOperation的 NSoperation的subclass
class HTTPBinManagerOperation: AsynOperation {
    
    private let manager = ApiManager()
    private var dic1: NSDictionary?
    private var dic2: NSDictionary?
    private var image: UIImage?

    var delegate: HTTPBinManagerOperationDelegate?
    
    override func execute() {
        manager.fetchGetResponse()
            .continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchGetResponse 成功了")
                self.dic1 = task.result as? NSDictionary
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(0.33)
                })
                
                return self.manager.postCustomerName("Alex")
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("postCustomerName 成功了")
                self.dic2 = task.result as? NSDictionary
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(0.66)
                })
                
                return self.manager.fetchImage()
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchImage 成功了")
                self.image = task.result as? UIImage
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(1)
                    self.delegate?.HTTPBinManagerOperationDidSuccess(self.dic1!, dic2: self.dic2!, image: self.image!)
                })
                
                return nil
            }.continueWithBlock { (task) -> AnyObject! in
                if task.error != nil {
                    print("失敗了")
                    print("\(task.error)")
                    self.delegate?.HTTPBinManagerOperationDidFail()
                    self.finish()
                }
                
                return nil
        }

    }
    
    // 5. 實作canel，中斷operation
    override func cancel() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.finish()
            self.delegate?.HTTPBinManagerOperationDidCancel()
        })
    }
    
}
