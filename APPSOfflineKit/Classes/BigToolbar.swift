//
//  BigToolbar.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/22/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

@IBDesignable
open class BigToolbar: UIToolbar {

    open static let toolbarHeight: CGFloat = 100.0

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = BigToolbar.toolbarHeight
        return sizeThatFits
    }
    
    override open var intrinsicContentSize : CGSize {
        var size = super.intrinsicContentSize
        size.height = BigToolbar.toolbarHeight
        return size
    }
}
