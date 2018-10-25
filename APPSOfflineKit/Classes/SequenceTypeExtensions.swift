//
//  SequenceTypeExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/22/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//


public extension Sequence {
    
    /// Categorizes elements of self into a dictionary, with the keys given by keyFunc
    
    func categorize<U : Hashable>(_ keyFunc: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = keyFunc(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
    
    
    /**
      Groups elements of self into sections. Each section is grouped by
     a title provided by titleFunc. The ordering of the sections is determined
     by the ordering of the titles as sorted by isTitleOrderedBefore. The
     ordering of the elements within the sections is sorted by isItemOrderedBefore
     
     
     - parameter titleFunc:            function to return section title
     - parameter isTitleOrderedBefore: function to sort titles
     - parameter isItemOrderedBefore:  function to sort items within section
     
     - returns: ordered array of tuples whose first element is the title and second is an array
     of elements with the given title sorted by isItemOrderedBefore
     */
    func sortedGroups<U : Hashable>(_ titleFunc: (Iterator.Element) -> U,
        isTitleOrderedBefore:(_ key1: U, _ key2: U) -> Bool,
        isItemOrderedBefore:(_ item1: Iterator.Element, _ item2: Iterator.Element) -> Bool) -> [(U,[Iterator.Element])] {
            
            var dict = categorize(titleFunc)
            
            let sortedKeys = dict.keys.sorted(by: isTitleOrderedBefore)
            
            
            // Sort the elements within each domain
            for (key, values) in dict {
                dict[key] = values.sorted (by: isItemOrderedBefore)
            }
            
            var sections: [(U, [Iterator.Element])] = []
            for key in sortedKeys {
                sections.append((key, dict[key]!))
            }
            
            return sections
    }
}

