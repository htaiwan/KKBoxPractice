//
//  ApiManagerTests.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/4/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import XCTest
@testable import KK_Operation

class ApiManagerTests: XCTestCase {
    
    let manager = ApiManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchGetResponse() {
        let expectation = expectationWithDescription("此API fetchGetResponse()呼叫要成功")
        
        manager.fetchGetResponse().continueWithBlock { (task) -> AnyObject! in
            if task.error == nil {
                expectation.fulfill() // 要成功
                XCTAssertNotNil(task.result, "應該要取得dic物件")
                XCTAssertNotNil(task.result["headers"], "此dic物件要有key值 header")
                XCTAssertNotNil(task.result["origin"], "此dic物件要有key值 origin")
                XCTAssertNotNil(task.result["url"], "此dic物件要有key值 url")
            } else {
                XCTFail() // 不應該失敗
            }
            return nil
        }
        
        // 等待Asyn Task回復
        waitForExpectationsWithTimeout(3.0, handler: nil)
    }
    
    func testPostCustomerName() {
        let expectation = expectationWithDescription("此API PostCustomerName()呼叫要成功")
        
        manager.postCustomerName("Alex").continueWithBlock { (task) -> AnyObject! in
            if task.error == nil {
                expectation.fulfill()
                XCTAssertNotNil(task.result, "應該要取得dic物件")
                XCTAssertNotNil(task.result["form"], "此dic物件要有key值 form")
                XCTAssertEqual(task.result["form"], ["custname": "Alex"], "此custname對應的value要為Dic")
            } else {
                XCTFail() // 不應該失敗
            }
            return nil
        }
        
        // 等待Asyn Task回復
        waitForExpectationsWithTimeout(3.0, handler: nil)
    }
    
    func testFetchImage() {
        let expectation = expectationWithDescription("此API FetchImage()呼叫要成功")
        
        manager.fetchImage().continueWithBlock { (task) -> AnyObject! in
            if task.error == nil {
                expectation.fulfill()
                XCTAssertNotNil(task.result, "應該要取得值")
                XCTAssertTrue(task.result.isKindOfClass(UIImage), "回來的值應該是一個image物件")
            } else {
                XCTFail() // 不應該失敗
            }
            return nil
        }
        
        // 等待Asyn Task回復
        waitForExpectationsWithTimeout(3.0, handler: nil)
    }
    
}
