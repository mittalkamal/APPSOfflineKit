//
//  ActivityStatusViewController.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/29/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import APPSUIKit

open class ActivityStatusViewController: APPSSimpleActivityStatusViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        useBlurEffectBackground = false
        dialogViewBackgroundColor = UIColor.white
        dialogWidth = 220
        dialogHeight = 150
        activityIndicatorColor = UIColor(hex: 0x6c2225)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimatingActivityIndicator()
    }
    
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimatingActivityIndicator()
    }
    
}

