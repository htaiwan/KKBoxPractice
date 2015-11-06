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
    
    // 1. override executing
    private var _executing = false {
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
    
    // 2. override finished
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
    
    // 3. override cancel
    private var _cancel = false {
        willSet {
            willChangeValueForKey("isCancelled")
        }
        didSet {
            didChangeValueForKey("isCancelled")
        }
    }
    
    override var cancelled: Bool {
        return _cancel
    }
    
    override func start() {
        _executing = true
        execute()
    }
    
    func cancels() {
        _cancel = true
        finish()
    }
    
    func execute() {
        fatalError("必須在子類別複寫此方法")
    }
    
    func finish() {
        _executing = false        
        _finished = true
    }

}
