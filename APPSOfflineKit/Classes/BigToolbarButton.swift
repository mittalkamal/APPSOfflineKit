//
//  BigToolbarButton.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/22/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

@IBDesignable
open class BigToolbarButton: UIButton {

    // Distance between titleLabel and imageView
    @IBInspectable open var padding: CGFloat = 6
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let imageView = imageView, let titleLabel = titleLabel {
            let imageSize = imageView.frame.size
            let titleSize = titleLabel.frame.size
            let totalHeight = imageSize.height + titleSize.height + padding
            
            imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(totalHeight - titleSize.height), right: 0)
        }
        
    }
}
