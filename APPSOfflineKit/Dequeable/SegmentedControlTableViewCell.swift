//
//  SegmentedControlTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/25/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class SegmentedControlTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var segmentedControl: UISegmentedControl!
    @IBOutlet weak open var requiredFieldIndicator: UIView!

    // MARK: - Methods
    // MARK: Lifecycle
    
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
        segmentedControl.removeAllSegments()
        isRequired = false
    }

    open func configure(_ viewModel: SegmentedControlCellViewModel) {
        titleLabel.text = viewModel.titleText
        isRequired = viewModel.isRequired
        
        segmentedControl.removeAllSegments()
        for (i, title) in viewModel.titles.enumerated() {
            segmentedControl.insertSegment(withTitle: title, at: i, animated: false)
        }
        segmentedControl.selectedSegmentIndex = viewModel.selectedSegmentIndex
        segmentedControl.isEnabled              = viewModel.enabled
    }
    
    open var isRequired: Bool = false {
        didSet {
            guard let requiredFieldIndicator = requiredFieldIndicator else { return }
            requiredFieldIndicator.isHidden = !isRequired
        }
    }

}
