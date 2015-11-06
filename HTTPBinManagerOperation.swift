//
//  HTTPBinManagerOperation.swift
//  KK_Operation
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

// 4. HTTPBinManagerOperation 使用 delegate 向外部傳遞自己的狀態。
protocol HTTPBinManagerOperationDelegate {

    func HTTPBinManagerOperationDidFail()
    func HTTPBinManagerOperationDidCancel()
    func HTTPBinManagerOperationDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage)
    func HTTPBinManagerOperationUpdateProgress(progrss: Float)

}

// 4. 寫一個叫做 HTTPBinManagerOperation 的 NSOperation subclass
class HTTPBinManagerOperation: AsynOperation {
    
    private let manager = ApiManager()
    private var dic1: NSDictionary?
    private var dic2: NSDictionary?
    private var image: UIImage?

    var delegate: HTTPBinManagerOperationDelegate?
    
    override func execute() {
        
        // cancal 好像不該這樣寫
        sleep(1)
        if self.cancelled { return }

        // 4.1 對我們之前寫的 SDK 發送 fetchGetResponseWithCallback: 並等候回應。  
        manager.fetchGetResponse()
            .continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchGetResponse 成功了")
                self.dic1 = task.result as? NSDictionary
                // 4.2 如果前一步成功，先告訴 delegate 我們的執行進度到了 33%
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(0.33)
                })
                // 4.3 對我們之前寫的 SDK 發送 postCustomerName:callback: 並等候回應。
                return self.manager.postCustomerName("Alex")
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("postCustomerName 成功了")
                self.dic2 = task.result as? NSDictionary
                // 4.4 如果前一步成功，先告訴 delegate 我們的執行進度到了 66%
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(0.66)
                })
                // 4.5 對我們之前寫的 SDK 發送 fetchImageWithCallback: 並等候回應。
                return self.manager.fetchImage()
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchImage 成功了")
                self.image = task.result as? UIImage
                // 4.6 如果前一步成功，先告訴 delegate 我們的執行進度到了 100%，並且告訴 delegate 執行成功，並回傳前面抓取到的兩個 NSDcitionary 與一個 UIImage 物件
                self.finish()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.HTTPBinManagerOperationUpdateProgress(1)
                    self.delegate?.HTTPBinManagerOperationDidSuccess(self.dic1!, dic2: self.dic2!, image: self.image!)
                })
                
                return nil
            }.continueWithBlock { (task) -> AnyObject! in
                if task.error != nil {
                    print("失敗了")
                    print("\(task.error)")
                    //  如果失敗就整個取消作業，並且告訴 delegate 失敗。 delegate method 要在 main thread 當中執行。
                    self.finish()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.HTTPBinManagerOperationDidFail()
                    })
                }
                
                return nil
        }

    }
    
    // 5. 這個 operation 要實作 cancel，發送 cancel 時，要立刻讓operation 停止，包括清除所有進行中的連線。
    override func cancel() {
        self.cancels()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.delegate?.HTTPBinManagerOperationDidCancel()
        })
    }
    
}
