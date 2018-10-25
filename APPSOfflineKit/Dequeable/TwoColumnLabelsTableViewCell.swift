//
//  TwoColumnLabelsTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/18/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class TwoColumnLabelsTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak open var leftColumnView: TwoColumnLabelsColumnView!
    @IBOutlet weak open var rightColumnView: TwoColumnLabelsColumnView!

    open override func awakeFromNib() {
        super.awakeFromNib()
        
        resetToDefaults()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        resetToDefaults()
    }
    
    open func resetToDefaults() {
        selectionStyle = .none
        leftColumnView.resetToDefaults()
        rightColumnView.resetToDefaults()
    }
    
    open func configure(_ viewModel: TextCellViewModel) {
        leftColumnView.configure(viewModel.leftViewModel)
        rightColumnView.configure(viewModel.rightViewModel)
        
        if let accessoryType = viewModel.accessoryType {
            self.accessoryType = accessoryType
        }
        
        if let selectionStyle = viewModel.selectionStyle {
            self.selectionStyle = selectionStyle
        }
    }
}

open class TwoColumnLabelsColumnView: FormHelpColumnView {
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var detailLabel: UILabel!

    open override func resetToDefaults() {
        super.resetToDefaults()
        
        titleLabel.text = nil
        detailLabel.text = nil
        helpLabel.text = nil
    }
    
    open func configure(_ viewModel: TextCellViewModel.TextFieldViewModel) {
        titleLabel.text     = viewModel.titleText
        detailLabel.text    = viewModel.detailText
        helpLabel.text      = viewModel.helpText
        detailLabel.tag     = viewModel.tag
        detailLabel.isEnabled = viewModel.enabled
    }
}


