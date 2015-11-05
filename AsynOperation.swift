//
//  AsynOperation.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

// 將operation改成Asyn
class AsynOperation: NSOperation {
    
    override var asynchronous: Bool {
        return true
    }
    
    private var _executing = false {
        // KVO，告訴系統要開始執行operation
        willSet {
            willChangeValueForKey("isExecuting")
        }
        didSet {
            didChangeValueForKey("isExecuting")
        }
    }
    
    override var executing: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
             willChangeValueForKey("isFinished")
        }
        didSet {
            didChangeValueForKey("isFinished")
        }
    }
    
    override var finished: Bool {
        return _finished
    }
    
    override func start() {
        _executing = true
        execute()
    }
    
    func execute() {
        fatalError("必須在子類別複寫此方法")
    }
    
    func finish() {
        _executing = false        
        _finished = true
    }

}
