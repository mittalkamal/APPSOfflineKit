//
//  ImageAttachmentTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/27/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class ImageAttachmentTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak open var dateLabel: UILabel!
    @IBOutlet weak open var timeLabel: UILabel!
    @IBOutlet weak open var imageAttachmentView: UIImageView!

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

    open func configure(_ viewModel: ImageAttachmentCellViewModel) {
        imageAttachmentView.image = viewModel.image
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
    }

}
