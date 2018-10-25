//
//  FormAction.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 3/31/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//


// MARK: - Actions

public enum FormAction {
    
    case insertSection(index: Int, section: FormSection)
    case deleteSection(index: Int)
    case reloadSection(index: Int, section: FormSection)
    case insertRow(indexPath: IndexPath, cellType: FormCellType)
    case deleteRow(indexPath: IndexPath)
    case reloadRow(indexPath: IndexPath, cellType: FormCellType)
}

