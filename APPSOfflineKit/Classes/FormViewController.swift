//
//  FormViewController.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 2/25/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit
import Reusable

/**
 The FormViewController is an abstract view controller using a table view backed by a FormViewModel.
 The values of the UI controls are reflected back into the view model as they are changed.
 As each control is changed a notification method (notifyTextChanged, notifySegmentedControlDidChangeValue, ...)
 is called for subclasses to be aware of the changes.
 */
open class FormViewController: UIViewController {
    
    @IBOutlet open weak var tableView: UITableView!
    
    open var activeTextInputView: UIView?
    open var displayedSections: [FormSection] = []
    
    
    // MARK: View lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications(true)
    }
    
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        registerForKeyboardNotifications(false)
    }
    
    
    
    // MARK: - Configuration
    
    open func configureTableView() {
        
        // Enable auto-sizing cells
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Enable auto-sizing header
        tableView.estimatedSectionHeaderHeight = 40 // size of StandardSectionHeaderView
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(cellType: TwoColumnLabelsTableViewCell.self)
        tableView.register(cellType: OneColumnLabelTableViewCell.self)
        tableView.register(cellType: TwoColumnTextFieldsTableViewCell.self)
        tableView.register(cellType: OneColumnTextViewTableViewCell.self)
        tableView.register(cellType: SegmentedControlTableViewCell.self)
        tableView.register(cellType: SwitchTableViewCell.self)
        tableView.register(cellType: ImageAttachmentTableViewCell.self)
    }

    

    // MARK: - Keyboard Handling

    func registerForKeyboardNotifications(_ register: Bool) {
        
        let center = NotificationCenter.default
        
        if register {
            center.addObserver(self, selector: #selector(FormViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            center.addObserver(self, selector: #selector(FormViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        } else {
            center.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
            center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    
    func keyboardWasShown(_ notif: Notification) {
        guard let info = notif.userInfo else { return }
        guard let kbSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
        if let activeTextInputView = activeTextInputView {
            tableView.scrollView(activeTextInputView, atScrollPosition: .none, animated: true)
        }
    }
    
    
    func keyboardWillBeHidden(_ notif: Notification) {
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }

    
    open func insertSection(_ section: FormSection, atIndex index: Int, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections.insert(section, at: index)
        tableView.insertSections(IndexSet(integer: index), with: rowAnimation)
    }
    
    
    open func deleteSectionAtIndex(_ index: Int, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections.remove(at: index)
        tableView.deleteSections(IndexSet(integer: index), with: rowAnimation)
    }
    
    
    open func reloadSection(_ section: FormSection, atIndex index: Int, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections[index] = section
        tableView.reloadSections(IndexSet(integer: index), with: rowAnimation)
    }
    

    open func insertCellType(_ cellType: FormCellType, atIndexPath indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections[indexPath.section].cellTypes.insert(cellType, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: rowAnimation)
    }
    
    
    open func deleteCellTypeAtIndexPath(_ indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections[indexPath.section].cellTypes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: rowAnimation)
    }
    
    
    open func reloadCellTypeAtIndexPath(_ cellType: FormCellType, atIndexPath indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        displayedSections[indexPath.section].cellTypes[indexPath.row] = cellType
        tableView.reloadRows(at: [indexPath], with: rowAnimation)
    }
    
    
    open func displayFormAction(_ action: FormAction) {
        
        switch action {
        case .insertSection(let index, let section):
            insertSection(section, atIndex: index, withRowAnimation: .fade)
            
        case .deleteSection(let index):
            deleteSectionAtIndex(index, withRowAnimation: .fade)
            
        case .reloadSection(let index, let section):
            reloadSection(section, atIndex: index, withRowAnimation: .none)
            
        case .insertRow(let indexPath, let cellType):
            insertCellType(cellType, atIndexPath: indexPath, withRowAnimation: .fade)
            
        case .deleteRow(let indexPath):
            deleteCellTypeAtIndexPath(indexPath, withRowAnimation: .fade)
            
        case .reloadRow(let indexPath, let cellType):
            reloadCellTypeAtIndexPath(cellType, atIndexPath: indexPath, withRowAnimation: .none)
        }
    }
    
    

}



// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return displayedSections.count
    }
    
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSections[section].cellTypes.count
    }
    
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = displayedSections[indexPath]
        
        switch cellType {
            
        case .oneColumnLabel(let cellViewModel):
            let cell: OneColumnLabelTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            return cell
            
            
        case .twoColumnLabels(let cellViewModel):
            let cell: TwoColumnLabelsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            return cell
            
            
        case .oneColumnTextView(let cellViewModel):
            let cell: OneColumnTextViewTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            cell.textView.delegate  = self
            return cell
            
            
        case .twoColumnTextFields(let cellViewModel):
            let cell: TwoColumnTextFieldsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            cell.leftColumnView.detailTextField.delegate = self
            cell.rightColumnView.detailTextField.delegate = self
            return cell
            
            
        case .segmentedControl(let cellViewModel):
            let cell: SegmentedControlTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            cell.segmentedControl.addTarget(self, action: #selector(FormViewController.segmentedControlDidChangeValue(_:)), for: .valueChanged)
            return cell
        
        
        case .switchControl(let cellViewModel):
            let cell: SwitchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            cell.switchControl.addTarget(self, action: #selector(FormViewController.switchControlDidChangeValue(_:)), for: .valueChanged)
            return cell
            
            
        case .imageAttachment(let cellViewModel):
            let cell: ImageAttachmentTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(cellViewModel)
            return cell
       }
        
    }
    
    
    final func segmentedControlDidChangeValue(_ segmentedControl: UISegmentedControl) {
        
        guard let indexPath = tableView.indexPathForView(segmentedControl) else { return }
        
        view.endEditing(true)
        
        let cellType = displayedSections[indexPath]
        
        // Update view model
        if case .segmentedControl(let viewModel) = cellType {
            viewModel.selectedSegmentIndex = segmentedControl.selectedSegmentIndex
            
            notifySegmentedControlDidChangeValue(segmentedControl, atIndexPath: indexPath, tag: viewModel.tag)
        }
    }
    
    
    final func switchControlDidChangeValue(_ switchControl: UISwitch) {
        
        guard let indexPath = tableView.indexPathForView(switchControl) else { return }
        
        view.endEditing(true)

        let cellType = displayedSections[indexPath]
        
        // Update view model
        if case .switchControl(let viewModel) = cellType {
            viewModel.switchOn = switchControl.isOn
            
            notifySwitchControlDidChangeValue(switchControl, atIndexPath: indexPath, tag: viewModel.tag)
        }
    }
    
    
    /**
     This is called when a text view's or text field's DidEndEditing method is called.
     
     - parameter text:      text from exited text view or te
     - parameter indexPath: index path of changed cell
     - parameter tag:       tag of UITextField or UITextView with new text
     */
    final func setText(_ text: String?, atIndexPath indexPath: IndexPath, tag: Int) {
        
        let cellType = displayedSections[indexPath]
        
        switch cellType {
            
        case .oneColumnTextView(let cellViewModel):
            cellViewModel.leftViewModel.detailText = text
            notifyTextChanged(text, atIndexPath: indexPath, tag: tag)
            
        case .twoColumnTextFields(let cellViewModel):
            switch tag {
            case cellViewModel.leftViewModel.tag:
                cellViewModel.leftViewModel.detailText = text
            case cellViewModel.rightViewModel.tag:
                cellViewModel.rightViewModel.detailText = text
                
            default:
                break
            }
            
            notifyTextChanged(text, atIndexPath: indexPath, tag: tag)

        default:
            break
        }
    }
    
    open func indexPathForTag(_ tag: Int) -> IndexPath? {
        
        for section in 0..<displayedSections.count {
            for row in 0..<displayedSections[section].cellTypes.count {
                
                let indexPath = IndexPath(row: row, section: section)
                let cellType = displayedSections[indexPath]
                
                switch cellType {
                case .oneColumnTextView(let cellViewModel):
                    if cellViewModel.leftViewModel.tag == tag {
                        return indexPath
                    }
                case .twoColumnTextFields(let cellViewModel):
                    if cellViewModel.leftViewModel.tag == tag ||
                        cellViewModel.rightViewModel.tag == tag {
                        return indexPath
                    }
                    
                case .segmentedControl(let cellViewModel):
                    if cellViewModel.tag == tag {
                        return indexPath
                    }
                    
                case .switchControl(let cellViewModel):
                    if cellViewModel.tag == tag {
                        return indexPath
                    }
                    
                case .imageAttachment(let cellViewModel):
                    if cellViewModel.tag == tag {
                        return indexPath
                    }
                    
                default:
                    break
                }
            }
        }
        return nil
    }
    
    
    open func cellTypeForTag(_ tag: Int) -> FormCellType? {
        
        if let indexPath = indexPathForTag(tag) {
            return displayedSections[indexPath]
        }
        
        return nil
    }

}



// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !view.endEditing(false) {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        
        switch cell {
            
        case let textFieldCell as TwoColumnTextFieldsTableViewCell:
            textFieldCell.leftColumnView.detailTextField.becomeFirstResponder()
            
        case let textViewCell as OneColumnTextViewTableViewCell:
            textViewCell.textView.becomeFirstResponder()
            
        default:
            break
        }
        
    }
    
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let displayedSection = displayedSections[section]

        let headerView = StandardSectionHeaderView.loadFromNib()
        headerView.titleLabel!.text = displayedSection.title
        headerView.backgroundColor = displayedSection.backgroundColor
        
        return headerView
    }
    
}



// MARK: - UITextFieldDelegate

extension FormViewController: UITextFieldDelegate {
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextInputView = textField
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextInputView = nil
        
        // Update view model
        if let indexPath = tableView.indexPathForView(textField) {
            setText(textField.text, atIndexPath: indexPath, tag: textField.tag)
        }
    }
    
}



// MARK: - UITextViewDelegate

extension FormViewController: UITextViewDelegate {
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        activeTextInputView = textView
    }
    
    
    open func textViewDidEndEditing(_ textView: UITextView) {
        activeTextInputView =  nil
        
        // Update view model
        if let indexPath = tableView.indexPathForView(textView) {
            setText(textView.text, atIndexPath: indexPath, tag: textView.tag)
        }
    }
    
}



// MARK: - Subclass Override methods

extension FormViewController {
    
    open func notifyTextChanged(_ text: String?, atIndexPath indexPath: IndexPath, tag: Int) {
    }
    

    open func notifySegmentedControlDidChangeValue(_ segmentedControl: UISegmentedControl, atIndexPath: IndexPath, tag: Int) {
    }
    
    
    open func notifySwitchControlDidChangeValue(_ switchControl: UISwitch, atIndexPath: IndexPath, tag: Int) {
    }
    
}
