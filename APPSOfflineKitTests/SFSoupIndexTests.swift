//
//  SFSoupIndexTests.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 5/6/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

@testable import APPSOfflineKit
import XCTest

class SFSoupIndexTests: XCTestCase {

    
    func testArrayOfIndexSpecsIsEqualToIndexSpecsAreEqual() {
        
        // Setup
        let fieldName1 = "Name"
        let fieldName2 = "Name"
        let soupIndex1 = SFSoupIndex(path: fieldName1, indexType: kSoupIndexTypeString, columnName: fieldName1)!
        let soupIndex2 = SFSoupIndex(path: fieldName2, indexType: kSoupIndexTypeString, columnName: fieldName2)!
        
        // Execute
        let result = SFSoupIndex.arrayOfIndexSpecs([soupIndex1], isEqualToIndexSpecs: [soupIndex2], withColumnName: false)

        // Verify
        XCTAssertTrue(result)
    }
    
    
    func testArrayOfIndexSpecsIsEqualToIndexSpecsAreEqual2() {

        // Setup
        let fieldName1 = "Name"
        let fieldName2 = "Name"
        let fieldName3 = "Name3"
        let soupIndex1 = SFSoupIndex(path: fieldName1, indexType: kSoupIndexTypeString, columnName: fieldName1)!
        let soupIndex2 = SFSoupIndex(path: fieldName2, indexType: kSoupIndexTypeString, columnName: fieldName2)!
        let soupIndex3 = SFSoupIndex(path: fieldName3, indexType: kSoupIndexTypeString, columnName: fieldName3)!

        let indices1 = [soupIndex1, soupIndex3]
        let indices2 = [soupIndex2, soupIndex3]
        
        // Execute
        let result = SFSoupIndex.arrayOfIndexSpecs(indices1, isEqualToIndexSpecs: indices2, withColumnName: false)
        
        // Verify
        XCTAssertTrue(result)
    }

    
    func testArrayOfIndexSpecsIsEqualToIndexSpecsAreNotEqual() {

        // Setup
        let fieldName1 = "Name"
        let fieldName2 = "Name2"
        let soupIndex1 = SFSoupIndex(path: fieldName1, indexType: kSoupIndexTypeString, columnName: fieldName1)!
        let soupIndex2 = SFSoupIndex(path: fieldName2, indexType: kSoupIndexTypeString, columnName: fieldName2)!
        
        let indices1 = [soupIndex1]
        let indices2 = [soupIndex2]
        
        // Execute
        let result = SFSoupIndex.arrayOfIndexSpecs(indices1, isEqualToIndexSpecs: indices2, withColumnName: false)
        
        // Verify
        XCTAssertFalse(result)
    }
    
    
    func testArrayOfIndexSpecsIsEqualToIndexSpecsAreNotEqual2() {

        // Setup
        let fieldName1 = "Name"
        let fieldName2 = "Name2"
        let fieldName3 = "Name3"
        let soupIndex1 = SFSoupIndex(path: fieldName1, indexType: kSoupIndexTypeString, columnName: fieldName1)!
        let soupIndex2 = SFSoupIndex(path: fieldName2, indexType: kSoupIndexTypeString, columnName: fieldName2)!
        let soupIndex3 = SFSoupIndex(path: fieldName3, indexType: kSoupIndexTypeString, columnName: fieldName3)!
        
        let indices1 = [soupIndex1, soupIndex2]
        let indices2 = [soupIndex2, soupIndex3]
        
        // Execute
        let result = SFSoupIndex.arrayOfIndexSpecs(indices1, isEqualToIndexSpecs: indices2, withColumnName: false)
        
        // Verify
        XCTAssertFalse(result)
    }

}
