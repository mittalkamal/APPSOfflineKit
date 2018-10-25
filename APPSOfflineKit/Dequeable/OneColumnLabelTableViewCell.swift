//
//  OneColumnLabelTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/18/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class OneColumnLabelTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var detailLabel: UILabel!
    
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
        titleLabel.text = nil
        detailLabel.text = nil
    }

    open func configure(_ viewModel: TextCellViewModel) {
        configure(viewModel.leftViewModel)
    }
    
    open func configure(_ viewModel: TextCellViewModel.TextFieldViewModel) {
        titleLabel.text     = viewModel.titleText
        detailLabel.text    = viewModel.detailText
        detailLabel.tag     = viewModel.tag
        detailLabel.isEnabled = viewModel.enabled
    }

}
