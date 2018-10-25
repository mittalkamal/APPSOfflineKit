//
//  UITextFieldExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/3/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation

extension UITextField {
    
    public func addMagnifyingGlass() {
        let magnifyingGlass = UILabel()
        magnifyingGlass.text = "🔍"
        magnifyingGlass.font = UIFont.systemFont(ofSize: 13)
        magnifyingGlass.textAlignment = .right
        magnifyingGlass.sizeToFit()
        
        // Increase width to give padding on left
        var bounds = magnifyingGlass.bounds
        bounds.size.width += 3;
        magnifyingGlass.bounds = bounds
        
        leftView = magnifyingGlass
        leftViewMode = .always
    }
    
    
    public func removeMagnifyingGlass() {
        leftView = nil
        leftViewMode = .never
    }
}
