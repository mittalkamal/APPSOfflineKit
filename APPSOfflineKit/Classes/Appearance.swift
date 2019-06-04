//
//  Appearance.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 4/14/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import UIKit

final public class Appearance {
    
    public static func configure(_ primaryColor: UIColor) {
        UIApplication.shared.delegate?.window??.tintColor = primaryColor
        
        configureNavigationBarAppearance(primaryColor)
        configureToolbarAppearance(primaryColor)
        configureTabBarAppearance(primaryColor)
    }
    
    
    static fileprivate func configureNavigationBarAppearance(_ primaryColor: UIColor) {
        UINavigationBar.appearance().barTintColor = primaryColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: navigationBarTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // Reset Nav Bar appearance back to defaults when contained in ModalNavigationController
        let modalNavBar = UINavigationBar.appearance(whenContainedInInstancesOf: [ModalNavigationController.self])
        modalNavBar.barTintColor = nil
        modalNavBar.tintColor = nil
        modalNavBar.isTranslucent = true
        modalNavBar.titleTextAttributes = nil
    }
    
    
    static fileprivate func configureToolbarAppearance(_ primaryColor: UIColor) {
        UIToolbar.appearance().barTintColor = UIColor.white
        UIToolbar.appearance().tintColor = UIColor.black
        UIToolbar.appearance().isTranslucent = false
    }
    
    
    static fileprivate func configureTabBarAppearance(_ primaryColor: UIColor) {
        let attrs = [NSAttributedString.Key.font: tabBarTitleFont]
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [BigTabBar.self])
        tabBarItem.setTitleTextAttributes(attrs, for: UIControl.State())
    }
    
    public static var navigationBarTitleFont: UIFont {
        let font = UIFont.systemFont(ofSize: 24)
        return font
    }
    
    public static var tabBarTitleFont: UIFont {
        let font = UIFont.systemFont(ofSize: 14)
        return font
    }
}
