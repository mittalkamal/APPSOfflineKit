//
//  StandardHeaderView.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/18/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable
import APPSUIKit

open class StandardHeaderView: UIView, NibLoadable {
        
    @IBOutlet weak open var titleLabel: UILabel!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        apps_addBorders(to: .bottom, with: UIColor.white, andWidth: UIView.apps_hairlineThickness())
    }

}
