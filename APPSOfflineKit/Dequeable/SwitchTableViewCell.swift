//
//  SwitchTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/26/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class SwitchTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var switchControl: UISwitch!
    
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
    }
    
    open func configure(_ viewModel: SwitchCellViewModel) {
        titleLabel.text   = viewModel.title
        switchControl.isOn  = viewModel.switchOn
        switchControl.tag = viewModel.tag
    }
}
