//
//  UIViewExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/10/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation

extension UIView {
    
    public struct TextArea {
        static let borderColor           = UIColor(hex: 0xc1c1c1).cgColor
        static let borderWidth: CGFloat  = 1.0
        static let cornerRadius: CGFloat = 5.0
    }

    public func applyTextAreaBorder() {
        layer.borderColor  = TextArea.borderColor
        layer.borderWidth  = TextArea.borderWidth
        layer.cornerRadius = TextArea.cornerRadius
    }
    
}
