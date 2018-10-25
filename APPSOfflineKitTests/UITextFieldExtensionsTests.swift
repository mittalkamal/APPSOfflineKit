//
//  UITextFieldExtensionsTests.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 5/17/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import XCTest

class UITextFieldExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAddMagnifyingGlass() {
        
        // Setup
        let textField = UITextField()
        
        // Execute
        textField.addMagnifyingGlass()
        
        // Verify
        XCTAssertEqual(textField.leftViewMode, UITextFieldViewMode.always)
        XCTAssertTrue(textField.leftView is UILabel)
        XCTAssertEqual((textField.leftView as! UILabel).text, "🔍")
    }
    
    
    func testRemoveMagnifyingGlass() {
        
        // Setup
        let textField = UITextField()
        textField.addMagnifyingGlass()
        
        
        // Execute
        textField.removeMagnifyingGlass()

        
        // Verify
        XCTAssertEqual(textField.leftViewMode, UITextFieldViewMode.never)
        XCTAssertNil(textField.leftView)
    
    }
    
    
}
