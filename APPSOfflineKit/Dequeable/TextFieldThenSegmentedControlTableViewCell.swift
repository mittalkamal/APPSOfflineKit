//
//  TextFieldThenSegmentedControlTableViewCell.swift
//  OCLQSOffline
//
//  Created by Sohail Ahmed on 11/18/2016.
//  Copyright © 2016 Ohio Jobs and Family Services Licensing and Permitting. All rights reserved.
//

import UIKit
import Reusable

// MARK: - Table View Cell

/**
 This two-column control gives you a UITextField in the left column, followed by a
 UISegmentedControl in the right column. In both cases, you have individually configurable
 titles, required indicators (optional) and help text (optional).
 
 The poorly named 'TwoColumnTextFieldsColumnView' and 'TwoColumnSegmentedControlsColumnView'
 are both instances of UIStackView.
 */
open class TextFieldThenSegmentedControlTableViewCell: UITableViewCell, NibReusable
{
    // MARK: - Properties
    // MARK: Outlets

    @IBOutlet weak open var leftColumnView: TwoColumnTextFieldsColumnView!
    @IBOutlet weak open var rightColumnView: SegmentedControlColumnView!
    
    // MARK: Derived Properties: Conveniences
    
    open var leftColumnValue: String? {
        return self.leftColumnView.detailTextField.text
    }
    
    open var rightColumnValue: String? {
        return self.rightColumnView.valueText
    }

    open var textFieldColumnView:TwoColumnTextFieldsColumnView {
        return leftColumnView
    }
    
    open var segmentedColumnView:SegmentedControlColumnView {
        return rightColumnView
    }
    
    
    
    // MARK: - Methods
    // MARK: Lifecycle

    open override func prepareForReuse() {
        super.prepareForReuse()
        
        leftColumnView.resetToDefaults()
        rightColumnView.resetToDefaults()
    }
    
    
    // MARK: Configuration
    
    /**
     Configures this table cell's editable TextField column, with values for the specified
     title, optional help text, etc.
     */
    open func configureLeftColumn( title: String,
                          value: String?,
                          placeholder: String? = nil,
                          textFieldDelegate: UITextFieldDelegate? = nil,
                          keyboardType: UIKeyboardType = .default,
                          helpText: String? = nil,
                          required: Bool = false )
    {
        // Identify that is is the left column that holds the Text Field.
        var columnView: TwoColumnTextFieldsColumnView
        columnView = self.leftColumnView
        
        // Apply values to specified column:
        columnView.detailTextField.delegate        = textFieldDelegate
        columnView.titleLabel.text                 = title
        columnView.detailTextField.text            = value
        columnView.detailTextField.placeholder     = placeholder
        columnView.detailTextField.keyboardType    = keyboardType
        columnView.helpLabel.text                  = helpText
        columnView.isRequired                      = required
    }
    
    
    open func configureRightColumn( title: String,
                                   options: [String],
                                   preselectedOption: String? = nil,
                                   helpText: String? = nil,
                                   required: Bool = false,
                                   onValueChangeHandler: (() -> Void)? = nil )
    {
        // Determine the preselected option index:
        var selectedIndex:Int?
        if let preselectedOption = preselectedOption {
            selectedIndex = options.index(of: preselectedOption)
        }
        
        // Are we missing a preselection?
        if (selectedIndex == nil) {
            // YES: Then advise this explicitly, so that we don't show one.
            selectedIndex = UISegmentedControlNoSegment
        }
        
        // Identify which column we're working with for a segmented control
        var columnView: SegmentedControlColumnView
        columnView = self.rightColumnView
        
        // Configure the contents. Note that "columnView" is actually the
        // UISegmentedControl instance for the given column.
        columnView.segments = options
        columnView.segmentedControl.selectedSegmentIndex = selectedIndex!
        columnView.titleLabel.text = title
        columnView.isRequired = required
        columnView.helpLabel.text = helpText
        columnView.onValueChangeHandler = onValueChangeHandler
    }

    
    // MARK: User Actions
    
    @IBAction func handleSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        segmentedColumnView.handleValueChanged(sender)
    }
    
} // class



// MARK: - Column View

open class SegmentedControlColumnView: FormHelpColumnView {
    
    // MARK: - Properties
    // MARK: Outlets
    @IBOutlet weak open var titleLabel:               UILabel!
    @IBOutlet weak open var segmentedControl:         UISegmentedControl!
    @IBOutlet weak open var requiredFieldIndicator:   UIView!

    // MARK: Callbacks
    open var onValueChangeHandler: (() -> Void)? = nil
    
    // MARK: Derived
    
    open var isRequired: Bool = false {
        didSet {
            guard let requiredFieldIndicator = requiredFieldIndicator else { return }
            requiredFieldIndicator.isHidden = !isRequired
        }
    }

    
    open var valueText : String? {
        guard segmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment else { return nil }
        return segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    
    open var segments : [String] {
        set {
            segmentedControl.removeAllSegments()
            
            for (segmentIndex, segmentTitle) in newValue.enumerated() {
                segmentedControl.insertSegment(withTitle: segmentTitle, at: segmentIndex, animated: false)
            }
        }
        
        get {
            var allTitles: [String] = []
            
            for i in 0..<segmentedControl.numberOfSegments {
                guard let segmentTitle = segmentedControl.titleForSegment(at: i) else { continue }
                allTitles.append(segmentTitle)
            }
            return allTitles
        }
        
    } // segments
    
    
    
    // MARK: - Methods
    // MARK: Lifecycle
    
    open override func resetToDefaults() {
        super.resetToDefaults()
        
        titleLabel.text = nil
        segmentedControl.removeAllSegments()
        isRequired = false
        onValueChangeHandler = nil
    }
    
    
    // MARK: User Actions
    func handleValueChanged(_ sender: UISegmentedControl) {
        // If we have a change handler for this segmented control, invoke it:
        if (onValueChangeHandler != nil) {
            NSLog("Value Changed to: \(String(describing: valueText))")
            onValueChangeHandler!()
        }
    }


    
} // SegmentedControlColumnView

