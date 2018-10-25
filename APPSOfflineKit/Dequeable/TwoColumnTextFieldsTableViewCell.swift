//
//  TwoColumnTextFieldsTableViewCell.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/18/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable



// MARK: - Table View Cell

open class TwoColumnTextFieldsTableViewCell: UITableViewCell, NibReusable {
    // MARK: - Properties
    // MARK: Outlets
    
    @IBOutlet weak open var leftColumnView: TwoColumnTextFieldsColumnView!
    @IBOutlet weak open var rightColumnView: TwoColumnTextFieldsColumnView!
    
    
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
        leftColumnView.resetToDefaults()
        rightColumnView.resetToDefaults()
    }

    
    // MARK: Configuration

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
    
    
    // MARK: User Actions
    
    @IBAction func handleEditingChanged(_ sender: UITextField) {
        
        // Determine if it is the left or right column, then
        // send along the action.
        var columnView:TwoColumnTextFieldsColumnView
        
        if leftColumnView.detailTextField == sender {
            columnView = leftColumnView
        }
        else {
            columnView = rightColumnView
        }
        
        columnView.handleEditingChanged(sender)
    }

} // TwoColumnTextFieldsTableViewCell



// MARK: - Column View

open class TwoColumnTextFieldsColumnView: FormHelpColumnView {
    
    // MARK: - Properties
    // MARK: Outlets
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var detailTextField: UITextField!
    @IBOutlet weak open var requiredFieldIndicator: UIView!

    
    // MARK: Callbacks
    
    open var onEditingChangeHandler: (() -> Void)? = nil

    
    // MARK: Derived
    
    open var isRequired: Bool = false {
        didSet {
            guard let requiredFieldIndicator = requiredFieldIndicator else { return }
            requiredFieldIndicator.isHidden = !isRequired
        }
    }
    
    open var valueText : String? {
        return detailTextField.text
    }

    
    
    // MARK: - Methods
    // MARK: Lifecycle

    open override func resetToDefaults() {
        super.resetToDefaults()
        
        titleLabel.text = nil
        detailTextField.text = nil
        detailTextField.placeholder = nil
        helpLabel.text = nil
        isRequired = false
        onEditingChangeHandler = nil
    }

    
    // MARK: Configuration

    open func configure(_ viewModel: TextCellViewModel.TextFieldViewModel) {
        titleLabel.text             = viewModel.titleText
        helpLabel.text              = viewModel.helpText
        detailTextField.text        = viewModel.detailText
        detailTextField.isHidden      = (viewModel.titleText == nil)
        detailTextField.tag         = viewModel.tag
        detailTextField.isEnabled     = viewModel.enabled
        detailTextField.placeholder = viewModel.placeholder
    }
    
    
    // MARK: User Actions
    func handleEditingChanged(_ sender: UITextField) {
        // If we have a change handler for this text field, invoke it:
        if (onEditingChangeHandler != nil) {
            onEditingChangeHandler!()
        }
    }

} // TwoColumnTextFieldsColumnView

