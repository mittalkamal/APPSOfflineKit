platform :ios, '10.1'
inhibit_all_warnings!

target 'APPSOfflineKit' do
  source 'https://github.com/CocoaPods/Specs.git'
    
  use_frameworks!
    
  # NB: get rid of next line once FMDB works with xcode 9
  pod 'FMDB', :git => 'https://github.com/forcedotcom/fmdb', :branch => '2.7.2_xcode9'
  
  pod 'SalesforceAnalytics', :path => 'SFDCsdk/SalesforceMobileSDK-iOS'
  pod 'SalesforceSDKCore', :path => 'SFDCsdk/SalesforceMobileSDK-iOS'
  pod 'SmartStore', :path => 'SFDCsdk/SalesforceMobileSDK-iOS'
  pod 'SmartSync', :path => 'SFDCsdk/SalesforceMobileSDK-iOS'
  pod 'PSOperations', '~> 3.0.0'
  pod 'Reusable'
    
end

