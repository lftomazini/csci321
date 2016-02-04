//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Luís Felipe on 2/1/16.
//  Copyright © 2016 Luís Felipe. All rights reserved.
//

import XCTest

class TipCalculatorUITests: XCTestCase {
    /// Application proxy.
    let app = XCUIApplication()
    
    ///
    /// Put setup code here. This method is called before the invocation of
    /// each test method in the class.
    ///
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    ///
    /// Put teardown code here. This method is called after the invocation of
    /// each test method in the class.
    ///
    override func tearDown() {
        super.tearDown()
    }
    
    ///
    /// Asserts that the textView formated the tips in the correct way
    ///
    func testForCorrectOutput() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let textField = app.textFields.element
        textField.tap()
        
        let deleteKey = app.keys["delete"]
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        textField.typeText("75")
        
        let mainView = app.otherElements.containingType(.Button, identifier: "Calculate").element
        mainView.tap()
        let keyboard = app.keyboards.element
        XCTAssertFalse(keyboard.exists)
        
        let calculateButton = app.buttons.element
        calculateButton.tap()
        
        let textView = app.textViews.element.value as? String
        let expected = "15%: $ 11.25\n10%: $ 7.50\n18%: $ 13.50\n20%: $ 15.00\n"
        XCTAssertEqual(textView, expected)
    }
    
}
