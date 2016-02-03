//
//  TipCalculatorModelTests.swift
//  TipCalculator
//
//  Created by Luís Felipe on 2/3/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import XCTest
@testable import TipCalculator

class TipCalculatorModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    ///
    /// Tests the calculate tip method.
    ///
    func testCalculateTip() {
        let testModel = TipCalculatorModel(totalBeforeTax: 33.25)
        XCTAssertEqualWithAccuracy(testModel.calculateTip(usingPercent: 10), 3.33, accuracy: 0.005, "10% tip incorrect")
        XCTAssertEqualWithAccuracy(testModel.calculateTip(usingPercent: 15), 4.99, accuracy: 0.005, "15% tip incorrect")
        XCTAssertEqualWithAccuracy(testModel.calculateTip(usingPercent: 18), 5.99, accuracy: 0.005, "18% tip incorrect")
        XCTAssertEqualWithAccuracy(testModel.calculateTip(usingPercent: 20), 6.65, accuracy: 0.005, "20% tip incorrect")
    }
    
    ///
    /// Tests the performance of the possibleTips method. There shouldn't be
    /// ny performance issues. This is just to demonstrate ow it's done.
    ///
    func testPerformanceExample() {
        self.measureBlock {
            let testModel = TipCalculatorModel(totalBeforeTax: 33.25)
            for _ in 1...1000 {
                _ = testModel.possibleTips()
            }
        }
    }
    
    ///
    /// Tests that an HTTP GET equest works properly.
    ///
    func testAssynchronousURLConnection() {
        let url = "http://www.bucknell.edu/"
        let expectation = expectationWithDescription("GET \(url)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: url)!, completionHandler: {(data, response, error) in expectation.fulfill()
        
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse  = response as! NSHTTPURLResponse! {
                XCTAssertEqual(HTTPResponse.URL!.absoluteString, url, "HTTP response url hould be equal to original url")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(HTTPResponse.MIMEType! as String, "text/html", "HTTP response content type")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
        })
        
    task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval, handler: {error in task.cancel()
        })
    }
}
