//
//  SubSectionTitleTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/26/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable
import APPSUIKit

// This class provides a centered label and a button on the right.
// The background is gray and may be changed by setting the
// cell's background color.
// By default the button is hidden. You must set hidden
// to false to display it.


open class SubSectionTitleTableViewCell: UITableViewCell, NibReusable {

    open weak var delegate: SubSectionTitleTableViewCellDelegate?
    
    @IBOutlet open weak var button: UIButton!
    @IBOutlet open weak var titleLabel: UILabel!
    @IBOutlet open weak var deletedLabel: APPSTextMaskLabel!
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(hex: 0x9e9e9e9e)
        button.isHidden = true
        deletedLabel.isHidden = true
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        button.isHidden = true
        deletedLabel.isHidden = true
        delegate = nil
    }
    
    @IBAction open func handleEditButtonTap() {
        delegate?.subSectionTitleTableViewCellDidTapButton(self)
    }
    
}


public protocol SubSectionTitleTableViewCellDelegate: NSObjectProtocol {
    func subSectionTitleTableViewCellDidTapButton(_ cell: SubSectionTitleTableViewCell)
}
