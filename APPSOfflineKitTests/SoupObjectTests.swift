//
//  SoupObjectTests.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/8/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

@testable import APPSOfflineKit
import APPSOfflineKit
import XCTest

class SoupObjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     Verify that setting two subkeys stores both values
     */
    func testSetNullObjectForKeyPath_twoSubKeys() {
        
        // Setup
        let firstKey = "RecordType.Name"
        let secondKey = "RecordType.Id"
        let firstValue = "John"
        let secondValue = "111"
        let dict = NSMutableDictionary()
        
        // Execute
        dict.setNullObject(firstValue, forKeyPath: firstKey)
        dict.setNullObject(secondValue, forKeyPath: secondKey)
        
        
        // Verify
        XCTAssertNotNil(dict.value(forKeyPath: firstKey))
        XCTAssertNotNil(dict.value(forKeyPath: secondKey))
        XCTAssertEqual(dict.value(forKeyPath: firstKey) as? String, firstValue)
        XCTAssertEqual(dict.value(forKeyPath: secondKey) as? String, secondValue)
    }
    
    
    /**
     Verify that setting a value of nil with SetNullObjectForKeyPath actually stores NSNull
     */
    func testSetNullObjectForKeyPath_nullValue() {
        
        // Setup
        let firstKey = "RecordType.Name"
        let dict = NSMutableDictionary()
        
        // Execute
        dict.setNullObject(nil, forKeyPath: firstKey)
        
        
        // Verify
        XCTAssertNotNil(dict.value(forKeyPath: firstKey))
        XCTAssertEqual(dict.value(forKeyPath: firstKey) as? NSNull , NSNull())
    }
    
    
    /**
     Verify that NonNullObjectForKeyPath returns nil for a stored NSNull
     */
    func testNonNullObjectForKeyPath_returnNil() {
        
        // Setup
        let firstKey = "RecordType.Name"
        let dict = NSMutableDictionary()
        dict.setNullObject(nil, forKeyPath: firstKey)
        
        // Execute
        let result = dict.nonNullObject(forKeyPath: firstKey)
        
        // Verify
        XCTAssertNil(result)
    }
    
    /**
     Whens SalesForce downloads a relationship such as Visit_Tool_Used__r.Name
     it stores a key "Visit_Tool_Used__r" with value NSNull. When we go to set
     a real value with the key "Visit_Tool_Used__r.Name" a mutable dictionary 
     needs to replace the NSNull for key "Visit_Tool_Used__r" and then the
     value go into this dictionary with the key "Name"
     */
    func testNonNullObjectForKeyPath_SetNullThenValueForRelationship() {
        
        // Setup
        let firstKey = "Visit_Tool_Used__r"
        let secondKey = "Visit_Tool_Used__r.Name"
        let name = "StandardItem"
        let dict = NSMutableDictionary()
        dict.setNullObject(NSNull(), forKeyPath: firstKey)
        
        // Execute
        let result = dict.nonNullObject(forKeyPath: firstKey)
        
        // Verify
        XCTAssertNil(result)
        XCTAssertEqual(dict.value(forKeyPath: firstKey) as? NSNull , NSNull())
        
        
        dict.setNullObject(name, forKeyPath: secondKey)
        if let result = dict.nonNullObject(forKeyPath: secondKey) as? String {
            XCTAssertEqual(result, name)
        }
    }
    
}
