//
//  UITableViewExtensions.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/29/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit


extension UITableView {
    
    /**
     Scrolls through the table view until a row identified by a subview is at a particular location on the screen.
     
     - parameter view:             A subview of a visible cell
     - parameter atScrollPosition: A constant that identifies a relative position in the table view (top, middle, bottom) for row when scrolling concludes.
     - parameter animated:         True if you want to animate the change in position; false if it should be immediate.
     */
    open func scrollView(_ view: UIView, atScrollPosition: UITableViewScrollPosition, animated: Bool) {
        if let indexPath = indexPathForView(view) {
            scrollToRow(at: indexPath, at: atScrollPosition, animated: animated)
        }
    }

    
    /**
     Returns the indexPath of the visible cell containing view.
     
     - parameter view: subview of receiver
     
     - returns: An index path representing the row and section associated with view, or nil if the view is out of the bounds of any row.
     */
    open func indexPathForView(_ view: UIView) -> IndexPath? {
        // Other implementations on GitHub use view.convertPoint(CGPointZero, toView: self) but this
        // is incorrect if view is a textView scrolled to the bottom such that it's bounds zero point is scrolled
        // into the cell above it.
        guard let ptInTableView = view.superview?.convert(view.center, to: self) else { return nil }
        let indexPath = indexPathForRow(at: ptInTableView)
        return indexPath
    }
    
    
    /**
     Scrolls through the table view until the first row is at the top of the screen.
     
     - parameter animated: true if you want to animate the change in position; false if it should be immediate.
     */
    open func scrollToTop(_ animated: Bool) {
        if numberOfSections > 0 {
            if numberOfRows(inSection: 0) > 0 {
                let firstIndexPath = IndexPath(row: 0, section: 0)
                scrollToRow(at: firstIndexPath, at: .top, animated: animated)
            }
        }
    }
    
    
    /**
     Removes empty table cells when there is no table footer, by creating a no-op table footer.
     */
    open func hideEmptySeparators() {
        let dummyTableFooterView = UIView()
        dummyTableFooterView.backgroundColor = UIColor.clear
        tableFooterView = dummyTableFooterView;
    }

    
    /**
     Calling beginUpdates and then endUpdates on a TableView causes it to re-layout all cells. When doing so,
     any changes in row heights are gracefully animated, without you needing to provide an animation block
     or timing of any kind. Just have a different value for row height returned in our data source method for row height
     to see an animation.
     */
    open func animateRowHeightChanges() {
        beginUpdates()
        endUpdates()
    }

    open func deselectAll(_ animated: Bool) {
        indexPathsForSelectedRows?.forEach { deselectRow(at: $0, animated: animated) }
    }
}
