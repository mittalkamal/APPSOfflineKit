//
//  FormHelpColumnView.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 11/7/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

// This class is used when help text is displayed at the bottom
// of this stack. When the help text is nil the spacing is set to 0. 
// You must set the outlet for helpLabel.
open class FormHelpColumnView: UIStackView {
    
    @IBOutlet weak open var helpLabel: UILabel!
    fileprivate (set) var initialSpacing: CGFloat = 0
    
    fileprivate var helpTextContext = 0
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        initialSpacing = spacing
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add observer to hide/display clear button
        helpLabel.addObserver(self, forKeyPath: "text", options: [.initial, .new], context: &helpTextContext)

        resetToDefaults()
    }
    
    deinit {
        helpLabel.removeObserver(self, forKeyPath: "text", context: &helpTextContext)
    }
    
    open func resetToDefaults() {
        spacing = initialSpacing
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &helpTextContext {
            updateSpacing()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    open func updateSpacing() {
        let helpIsEmpty = helpLabel.text.flatMap({$0.isEmpty}) ?? true
        spacing = helpIsEmpty ? 0.0 : initialSpacing
        setNeedsLayout()
    }
    
}


