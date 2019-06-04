//
//  BigTabBar.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/16/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

@IBDesignable
open class BigTabBar: UITabBar {
    
    public static let tabBarHeight: CGFloat = 100.0

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = BigTabBar.tabBarHeight
        return sizeThatFits
    }
}
