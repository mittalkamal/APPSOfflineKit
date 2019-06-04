//
//  NSAttributedStringExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 9/26/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//


extension NSAttributedString {
    
    /// Returns an attributed string suitable for displaying a "No Result" message in a table view
    public static func noDataTitle(string str: String) -> NSAttributedString {
        
        let attributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 24),NSAttributedString.Key.foregroundColor.rawValue: UIColor.lightGray] as! [NSAttributedString.Key : Any]
        
       // NSAttributedString(string: str, attributes: [NSAttributedString.Key : Any]?)
        
        let attrString = NSAttributedString(string: str, attributes: attributes)
        return attrString
    }
}

