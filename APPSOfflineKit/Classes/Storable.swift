//
//  Storable.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 11/9/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

// Each model object from Salesforce should implement this protocol


public protocol Storable {
    associatedtype SoupObjectType: SoupObject
    var soupId: SoupId? { get set }
}

extension Storable {
    
    public var isStoredLocally: Bool {
        return (soupId != nil)
    }
    
    // Creates a syncOperation for this Storable
    public var syncOperation: SyncOperation<SoupObjectType> {
        guard let soupId = soupId else {
            fatalError("Trying to create a sync operation for object that hasn't been saved locally (no soupId)")
        }
        
        
        let soupManager = SoupManager<SoupObjectType>(soupDescription: SoupObjectType.dataSpec())
        //let operation = SyncOperation<SoupObjectType>(soupId: soupId, soupManager: soupManager)
        let operation = SyncOperation<SoupObjectType>(soupManager:soupManager)
        return operation
    }

}
