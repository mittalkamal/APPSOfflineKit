//
//  SFSoupIndexExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 5/6/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import SmartStore

extension SoupIndex {
    
    /**
     Compares two arrays of NSSoupIndexes for equality. Equality meaning equal number and contents of NSSoupIndexes but not necessarily 
     in the same order.
     */
    final public class func arrayOfIndexSpecs(_ indexSpecs: [SoupIndex], isEqualToIndexSpecs otherIndexSpecs: [SoupIndex], withColumnName: Bool) -> Bool {
        let indexSpecDicts = SoupIndex.asArrayOfDictionaries(indexSpecs, withColumnName: withColumnName)
        let otherIndexSpecDicts = SoupIndex.asArrayOfDictionaries(otherIndexSpecs, withColumnName: withColumnName)
        
        return NSCountedSet(array: indexSpecDicts).isEqual(to: NSCountedSet(array: otherIndexSpecDicts) as! Set<AnyHashable>)
    }
    
}
