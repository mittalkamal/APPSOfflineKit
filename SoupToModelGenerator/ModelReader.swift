//
//  ModelReader.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/10/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation


/// JSON Model file keys
let swiftModelNameKey    = "swiftModelName"// String; required
let objectTypeKey        = "objectType"// String; required
let soupNameKey          = "soupName"// String; required
let fieldsKey            = "fields"// Array; required
let fieldNameKey         = "fieldName"// String; required
let fieldTypeKey         = "fieldType"// String; required
let nullableKey          = "nullable"// BOOL; required
let searchableKey        = "searchable"// BOOL; optional - defaults to false
let swiftFieldNameKey    = "swiftFieldName"// String; required
let swiftPropertyNameKey = "swiftPropertyName"// String; required

typealias JSONDictionary = [String:AnyObject]

let ModelReaderErrorDomain = "SoupToModelGeneratorApplicationErrorDomain" // for use with NSError.
enum ModelReaderError: Int {
    case jsonTopLevelExpectedDictionary
    case missingSwiftModelName
    case missingObjectType
    case missingSoupName
    case missingFields
    case missingFieldName
    case missingTypeName
    case missingSearchable
    case missingSwiftName
    case missingSwiftProperty
    case missingNullable
    
    func asError() -> NSError {
        switch self {
            
        case .jsonTopLevelExpectedDictionary:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "Top Level Key must be a dictionary"])
            
        case .missingSwiftModelName:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(swiftModelNameKey)' not found"])
            
        case .missingObjectType:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(objectTypeKey)' not found"])
            
        case .missingSoupName:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(soupNameKey)' not found"])
            
        case .missingFields:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(fieldsKey)' not found"])
            
        case .missingFieldName:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(fieldNameKey)' not found"])
            
        case .missingTypeName:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(fieldTypeKey)' not found"])
            
        case .missingSearchable:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(searchableKey)' not found"])
            
        case .missingSwiftName:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(swiftFieldNameKey)' not found"])
            
        case .missingSwiftProperty:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(swiftPropertyNameKey)' not found"])
            
        case .missingNullable:
            return NSError(domain: ModelReaderErrorDomain, code: self.rawValue, userInfo: [NSLocalizedDescriptionKey: "key '\(nullableKey)' not found"])
            
        }
    }
}




class ModelDescriptionField : NSObject {
    
    enum ModelDescriptionFieldType: String {
        case String = "string"
        case Integer = "int"
        case Boolean = "bool"
        case Double = "double"
    }

    /*
    I wanted these to be "let" properties but the compiler requires the properties to
    be set before calling any methods that might throw. According to Chris Lattner this is something they want to
    fix. https://groups.google.com/forum/#!msg/swift-language/2_pjGV0sz80/4Bl0pwGdVR4J
    */
    fileprivate(set) var fieldName = ""
    fileprivate(set) var fieldType = ModelDescriptionFieldType.String.rawValue
    fileprivate(set) var swiftFieldName = ""
    fileprivate(set) var swiftPropertyName = ""
    fileprivate(set) var searchable  = false
    fileprivate(set) var nullable  = true
    

    /**
     Initializes a ModelDescriptionField with a dictionary. The dictionary must have
     keys of "fieldName", "fieldType", "nullable", and optionally "searchable".
     */
    init(dictionary: JSONDictionary) throws {
        super.init()
        
        guard let fieldName = dictionary[fieldNameKey] as? String else { throw ModelReaderError.missingFieldName.asError() }
        guard let typeString = dictionary[fieldTypeKey] as? String else { throw ModelReaderError.missingTypeName.asError() }
        guard let nullable = dictionary[nullableKey] as? NSNumber else { throw ModelReaderError.missingNullable.asError() }
        guard let fieldType = ModelDescriptionFieldType(rawValue: typeString)?.rawValue else { throw ModelReaderError.missingTypeName.asError() }
        
        let swiftFieldName = dictionary[swiftFieldNameKey] as? String ?? swiftFieldNameFromFieldName(fieldName)
        let swiftPropertyName = dictionary[swiftPropertyNameKey] as? String ?? swiftPropertyNameFromFieldName(fieldName)
        
        self.fieldName = fieldName
        self.fieldType = fieldType
        self.swiftFieldName = swiftFieldName
        self.swiftPropertyName = swiftPropertyName
        self.nullable = nullable.boolValue
        
        if let searchable = dictionary[searchableKey] as? NSNumber {
            self.searchable = searchable.boolValue
        }
    }
    
    /**
     Returns a string suitable for an SoupObjectSpec Field Name. This string
     is obtained by first removing an "__c" suffix, then separating the string
     into parts delimited by "_", capitalizing the parts and recombining.
     Example: "Provider_Address_City__c" -> "ProviderAddressCity"
     */
    func swiftFieldNameFromFieldName(_ fieldName: String) -> String {
        let swiftFieldName = componentsFromFieldName(fieldName).joined(separator: "")
        return swiftFieldName
    }
    
    
    /**
     Returns a string suitable for use as a property name. This string
     is obtained by first removing an "__c" suffix, then separating the string
     into parts delimited by "_", capitalizing the parts, lowercase the first part and recombining.
     Example: "Provider_Address_City__c" -> "providerAddressCity"
     */
    func swiftPropertyNameFromFieldName(_ fieldName: String) -> String {
        var components = componentsFromFieldName(fieldName)
        components[0] = components[0].lowercased()
        let swiftPropertyName = components.joined(separator: "")
        return swiftPropertyName
    }
    
    /**
     Returns an array of strings separated by "_". 
     If the string has a suffix of "__c" it is removed.
     If the string ends in "Date" the word "String" is appended.
     If the string ends in "Time" the word "String" is appended.
     This is so that an extension method ending in date or time
     can be provided.
     */
    func componentsFromFieldName(_ fieldName: String) -> [String] {
        var str = fieldName
        if str.hasSuffix("__c") {
            // remove suffix
            str = str.substring(to: str.characters.index(str.endIndex, offsetBy: -3))
        }
        
        let separatorSet = CharacterSet(charactersIn: "_.")
        var components = str.components(separatedBy: separatorSet).filter { !$0.isEmpty }.map { $0.capitalized }
        if components.last == "Date" {
            components.append("String")
        }
        if components.last == "Time" {
            components.append("String")
        }
        
        return components
    }
    
}

/**
 Reads a file containing a model description.
 
 Example: 
 {
     "soupName": "accounts",
     "objectType": "Account",
     "fields": [
         {
            "name": "Name",
            "type": "string",
            "searchable": true
         }
     ]
 }
 */




class ModelReader {
    
    /*
    I wanted these to be "let" properties but the compiler requires the properties to 
    be set before calling any methods that might throw. According to Chris Lattner this is something they want to
    fix. https://groups.google.com/forum/#!msg/swift-language/2_pjGV0sz80/4Bl0pwGdVR4J
    */
    fileprivate(set) var swiftModelName = ""
    fileprivate(set) var objectType = ""
    fileprivate(set) var soupName = ""
    fileprivate(set) var modelDescriptionFields = [ModelDescriptionField]()
    
    init(path: String) throws {
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions(rawValue:0))
        let contents = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue:0))
        
        guard let JSON = contents as? JSONDictionary else { throw ModelReaderError.jsonTopLevelExpectedDictionary.asError() }
        guard let swiftModelName = JSON[swiftModelNameKey] as? String else { throw ModelReaderError.missingSwiftModelName.asError() }
        guard let objectType = JSON[objectTypeKey] as? String else { throw ModelReaderError.missingObjectType.asError() }
        guard let soupName = JSON[soupNameKey] as? String else { throw ModelReaderError.missingSoupName.asError() }
        guard let fields = JSON[fieldsKey] as? [JSONDictionary] else { throw ModelReaderError.missingFields.asError() }
        
        self.swiftModelName = swiftModelName
        self.objectType = objectType
        self.soupName = soupName
        self.modelDescriptionFields = try fields.map { try ModelDescriptionField(dictionary: $0) }
    }
}
