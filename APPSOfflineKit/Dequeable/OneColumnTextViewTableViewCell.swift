//
//  OneColumnTextViewTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/27/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

open class OneColumnTextViewTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var textView: UITextView!
    @IBOutlet weak open var requiredFieldIndicator: UIView!

    // MARK: Derived
    
    open var isRequired: Bool = false {
        didSet {
            guard let requiredFieldIndicator = requiredFieldIndicator else { return }
            requiredFieldIndicator.isHidden = !isRequired
        }
    }
    

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
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets.zero
        isRequired = false
    }

    // MARK: Configuration

    open func configure(_ title: String?, detailText: String?) {
        let leftViewModel = TextCellViewModel.TextFieldViewModel(titleText: title, detailText: detailText)
        let viewModel = TextCellViewModel(leftViewModel: leftViewModel)
        configure(viewModel)
    }

    open func configure(_ viewModel: TextCellViewModel) {
        configure(viewModel.leftViewModel)
    }
    
    func configure(_ viewModel: TextCellViewModel.TextFieldViewModel) {
        titleLabel.text   = viewModel.titleText
        textView.text     = viewModel.detailText
        textView.tag      = viewModel.tag
        textView.isEditable = viewModel.enabled
    }

}
