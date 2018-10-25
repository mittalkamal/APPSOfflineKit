//
//  StandardSectionHeaderView.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/18/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable
import APPSUIKit

public protocol StandardSectionHeader {
    var height : CGFloat { get }
    var titleLabel : UILabel! { get }
}

open class StandardSectionHeaderView: UIView, NibReusable, StandardSectionHeader {
    
    open static var height : CGFloat = 40
    open var height : CGFloat = 40
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var imageView: UIImageView!
    @IBOutlet weak open var textMaskLabel: APPSTextMaskLabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.image = nil
        titleLabel.text = nil
        textMaskLabel.isHidden = true
        textMaskLabel.text = nil
    }
}
