//
//  EditableTableViewCells.swift
//  OCLQSOffline
//
//  Created by Sohail Ahmed on 11/16/16.
//  Copyright © 2016 Ohio Jobs and Family Services Licensing and Permitting. All rights reserved.
//

// MARK: Enums
public enum TwoColumnCellColumnType: Int {
    case left = 0
    case right
}



// MARK: - Extension: Two Column Text Fields Table View Cell
public extension TwoColumnTextFieldsTableViewCell {
    
    // MARK: Derived Properties: Conveniences

    public var leftColumnValue: String? {
        return leftColumnView.detailTextField.text
    }
    
    
    public var rightColumnValue: String? {
        return rightColumnView.detailTextField.text
    }

    
    public var value: String? {
        return leftColumnValue
    }
    
    
    // MARK: Configuration
    
    /**
     Configures this table cell with an editable TextField, with values for just one
     column. We use the left column in this case.
     */
    public func configure(title: String,
                   value: String?,
                   placeholder: String? = nil,
                   textFieldDelegate: UITextFieldDelegate? = nil,
                   keyboardType: UIKeyboardType = .default,
                   autocapitalizationType: UITextAutocapitalizationType = .words,
                   helpText: String? = nil,
                   required: Bool = false,
                   onEditingChangeHandler: (() -> Void)? = nil )
    {
        // Left Column:
        configureColumn(.left,
                        title: title,
                        value: value,
                        placeholder: placeholder,
                        textFieldDelegate: textFieldDelegate,
                        keyboardType: keyboardType,
                        autocapitalizationType: autocapitalizationType,
                        helpText: helpText,
                        required: required,
                        onEditingChangeHandler: onEditingChangeHandler)
        
        // Right Column: (disabled)
        self.rightColumnView.detailTextField.isEnabled        = false
    }
    
    
    /**
     Configures this table cell with an editable TextField, with values for just the
     left column with the presumption that we are still going to use the right column too.
     */
    public func configureLeftColumn(title: String,
                                   value: String?,
                                   placeholder: String? = nil,
                                   textFieldDelegate: UITextFieldDelegate? = nil,
                                   keyboardType: UIKeyboardType = .default,
                                   autocapitalizationType: UITextAutocapitalizationType = .words,
                                   helpText: String? = nil,
                                   required: Bool = false,
                                   onEditingChangeHandler: (() -> Void)? = nil )
    {
        configureColumn(.left,
                        title: title,
                        value: value,
                        placeholder: placeholder,
                        textFieldDelegate: textFieldDelegate,
                        keyboardType: keyboardType,
                        autocapitalizationType: autocapitalizationType,
                        helpText: helpText,
                        required: required,
                        onEditingChangeHandler: onEditingChangeHandler)
    }

    
    /**
     Configures this table cell with an editable TextField, with values for just the
     right column with the presumption that we are still going to use the left column too.
     */
    public func configureRightColumn(title: String,
                                    value: String?,
                                    placeholder: String? = nil,
                                    textFieldDelegate: UITextFieldDelegate? = nil,
                                    keyboardType: UIKeyboardType = .default,
                                    autocapitalizationType: UITextAutocapitalizationType = .words,
                                    helpText: String? = nil,
                                    required: Bool = false,
                                    onEditingChangeHandler: (() -> Void)? = nil )
    {
        configureColumn(.right,
                        title: title,
                        value: value,
                        placeholder: placeholder,
                        textFieldDelegate: textFieldDelegate,
                        keyboardType: keyboardType,
                        autocapitalizationType: autocapitalizationType,
                        helpText: helpText,
                        required: required,
                        onEditingChangeHandler: onEditingChangeHandler )
    }
    
    
    /**
     Configures this table cell with an editable TextField, with values for the specified
     column. Call this once for each column.
     */
    public func configureColumn( _ column: TwoColumnCellColumnType,
                          title: String,
                          value: String?,
                          placeholder: String? = nil,
                          textFieldDelegate: UITextFieldDelegate? = nil,
                          keyboardType: UIKeyboardType = .default,
                          autocapitalizationType: UITextAutocapitalizationType = .words,
                          helpText: String? = nil,
                          required: Bool = false,
                          onEditingChangeHandler: (() -> Void)? = nil )
    {
        var columnView: TwoColumnTextFieldsColumnView
        
        switch column {
            case .left:
                columnView = self.leftColumnView
            case .right:
                columnView = self.rightColumnView
        }
        
        // Apply values to specified column:
        columnView.detailTextField.delegate               = textFieldDelegate
        columnView.titleLabel.text                        = title
        columnView.detailTextField.text                   = value
        columnView.detailTextField.placeholder            = placeholder ?? title
        columnView.detailTextField.keyboardType           = keyboardType
        columnView.detailTextField.autocapitalizationType = autocapitalizationType
        columnView.helpLabel.text                         = helpText
        columnView.isRequired                             = required
        columnView.onEditingChangeHandler                 = onEditingChangeHandler
    }
    
} // TwoColumnTextFieldsTableViewCell

