//
//  DisplayedSectionHeaderType.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/27/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation

/**
 Protocol used in view models to configure
 Section Header views
 */
public protocol DisplayedSectionHeaderType {
    var title: String? { get }
    var titleAlignment: NSTextAlignment { get }
    var backgroundColor: UIColor? { get }
    var imageName: String? { get }
}


/**
 This extension provides defaults for those
 implementing the protocol.
 */
public extension DisplayedSectionHeaderType {
    var title: String? { return nil }
    var titleAlignment: NSTextAlignment { return .left }
    var backgroundColor: UIColor? { return UIColor(hex: 0x313131) }
    var imageName: String? { return nil }
}
