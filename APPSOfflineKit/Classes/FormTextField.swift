//
//  FormTextField.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/28/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

// FormTextField is meant to be used when borderStyle is .None
// and some padding needs to be added so that a border can be
// put around the edge of the text field. The padding can be
// set in InterfaceBuilder.

@IBDesignable
open class FormTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.textRect(forBounds: bounds)
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
