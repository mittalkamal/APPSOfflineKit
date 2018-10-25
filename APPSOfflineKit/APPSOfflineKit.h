//
//  APPSOfflineKit.h
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 8/16/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for APPSOfflineKit.
FOUNDATION_EXPORT double APPSOfflineKitVersionNumber;

//! Project version string for APPSOfflineKit.
FOUNDATION_EXPORT const unsigned char APPSOfflineKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <APPSOfflineKit/PublicHeader.h>


#import <APPSOfflineKit/SoupObject.h>
#import <APPSOfflineKit/SoupDescription.h>
#import <APPSOfflineKit/SoupPropertyDescription.h>

// Private header - imported here because bridging headers aren't allowed in frameworks
// and the header is needed in a swift test file.
#import <APPSOfflineKit/SoupObject+Internal.h>


// Salesforce

#import <SalesforceAnalytics/SalesforceAnalytics.h>
#import <SalesforceSDKCore/SalesforceSDKCore.h>
#import <SmartStore/SmartStore.h>
#import <SmartSync/SmartSync.h>
