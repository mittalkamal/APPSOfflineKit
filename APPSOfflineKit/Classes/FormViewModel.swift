//
//  FormViewModel.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/25/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation

/**
 This structures form the view model for use with FormViewController.
*/
public indirect enum FormCellType {
    
    case oneColumnLabel(TextCellViewModel)
    
    case twoColumnLabels(TextCellViewModel)
    
    case oneColumnTextView(TextCellViewModel)
    
    case twoColumnTextFields(TextCellViewModel)
    
    case segmentedControl(SegmentedControlCellViewModel)
    
    case switchControl(SwitchCellViewModel)
    
    case imageAttachment(ImageAttachmentCellViewModel)
}

/**
 This is the top level view model that the FormViewController
 holds a reference to. FormSections are added to it.
 */
open class FormViewModel
{
    open var navigationItemTitle: String = ""
    open var sections: [FormSection] = []
    
    public init() {
    }
}


open class FormSection: DisplayedSectionHeaderType {
    open var title: String?
    open var cellTypes: [FormCellType] = []
    
    public init(title:String?, cellTypes: [FormCellType]) {
        self.title = title
        self.cellTypes = cellTypes
    }
}


// MARK: - Cell View Models

open class TextCellViewModel {
    
    open var accessoryType: UITableViewCellAccessoryType? //= .None
    open var selectionStyle: UITableViewCellSelectionStyle? // = .Default
    
    open class TextFieldViewModel {
        open var titleText: String?
        open var detailText: String?
        open var placeholder: String?
        open var helpText: String?
        open var tag: Int = 0
        open var enabled = true
       
        public init(titleText: String? = nil, detailText: String? = nil, placeholder: String? = nil, helpText: String? = nil, tag: Int = 0, enabled: Bool = true) {
            self.titleText = titleText
            self.detailText = detailText
            self.placeholder = placeholder
            self.helpText = helpText
            self.tag = tag
            self.enabled = enabled
        }
    }
    
    open var leftViewModel: TextFieldViewModel
    open var rightViewModel: TextFieldViewModel

    public init(leftViewModel: TextFieldViewModel, rightViewModel: TextFieldViewModel) {
        self.leftViewModel = leftViewModel
        self.rightViewModel = rightViewModel
    }
    
    public convenience init(leftViewModel: TextFieldViewModel) {
        self.init(leftViewModel: leftViewModel, rightViewModel: TextFieldViewModel())
    }
    
    public convenience init(rightViewModel: TextFieldViewModel) {
        self.init(leftViewModel: TextFieldViewModel(), rightViewModel: rightViewModel)
    }
}


open class SegmentedControlCellViewModel {
    open var titleText: String?
    open var titles: [String]          = []
    open var selectedSegmentIndex: Int = UISegmentedControlNoSegment
    open var enabled: Bool             = false
    open var tag: Int                  = 0
    open var isRequired: Bool          = false

    public init(titleText: String? = nil, titles: [String], selectedSegmentIndex: Int, enabled: Bool = true, tag: Int = 0) {
        self.titleText = titleText
        self.titles = titles
        self.selectedSegmentIndex = selectedSegmentIndex
        self.enabled = enabled
        self.tag = tag
    }
}


open class SwitchCellViewModel {
    open var title: String?
    open var switchOn: Bool = false
    open var tag: Int = 0
    
    public init(title: String?, switchOn: Bool, tag: Int = 0) {
        self.title = title
        self.switchOn = switchOn
        self.tag = tag
    }
}


open class ImageAttachmentCellViewModel {
    open var date: String?
    open var time: String?
    open var image: UIImage
    open var tag: Int
    
    public init(image: UIImage, date: String? = nil, time: String?, tag: Int = 0) {
        self.image = image
        self.date = date
        self.time = time
        self.tag = tag
    }
}


/**
 Allow a array of FormSection to be subscripted with an NSIndexPath
 */
public extension RangeReplaceableCollection where Iterator.Element == FormSection, Index == Int {
    
    public subscript(indexPath: IndexPath) -> FormCellType {
        get {
            return self[indexPath.section].cellTypes[indexPath.row]
        }
        set {
            let section = self[indexPath.section]
            section.cellTypes.replaceSubrange(indexPath.row...indexPath.row, with: [newValue])
            self.replaceSubrange(indexPath.section...indexPath.section, with: [section])
        }
    }
}

