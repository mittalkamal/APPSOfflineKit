//
//  SFSoupIndexExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 5/6/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import SmartStore

extension SFSoupIndex {
    
    /**
     Compares two arrays of NSSoupIndexes for equality. Equality meaning equal number and contents of NSSoupIndexes but not necessarily 
     in the same order.
     */
    final public class func arrayOfIndexSpecs(_ indexSpecs: [SFSoupIndex], isEqualToIndexSpecs otherIndexSpecs: [SFSoupIndex], withColumnName: Bool) -> Bool {
        let indexSpecDicts = SFSoupIndex.asArrayOfDictionaries(indexSpecs, withColumnName: withColumnName)
        let otherIndexSpecDicts = SFSoupIndex.asArrayOfDictionaries(otherIndexSpecs, withColumnName: withColumnName)
        
        return NSCountedSet(array: indexSpecDicts!).isEqual(NSCountedSet(array: otherIndexSpecDicts!))
    }
    
}
