//
//  SoupToModelGeneratorApplication.swift
//  APPSOfflineKit
//
//  Created by Ken Grigsby on 1/10/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

import Foundation

class SoupToModelGeneratorApplication
{
    fileprivate let inputJSONPath: String
    fileprivate let specTemplatePath: String
    fileprivate let dataTemplatePath: String
    fileprivate let modelTemplatePath: String
    fileprivate let outputDirectory: String

    
    
    // MARK: - Initialization
    
    init(inputJSONPath: String, specTemplatePath: String, dataTemplatePath: String, modelTemplatePath: String, outputDirectory: String)
    {
        self.inputJSONPath = (inputJSONPath as NSString).expandingTildeInPath
        self.specTemplatePath = (specTemplatePath as NSString).expandingTildeInPath
        self.dataTemplatePath = (dataTemplatePath as NSString).expandingTildeInPath
        self.modelTemplatePath = (modelTemplatePath as NSString).expandingTildeInPath
        self.outputDirectory = (outputDirectory as NSString).expandingTildeInPath
    }
    
    
    
    // MARK: - Public API
    
    func start() throws
    {
        let reader = try ModelReader(path: inputJSONPath)
        
        let filePaths = [
            (specTemplatePath, objectDataSpecURL(reader.swiftModelName)),   // Write CSoupObjectSpec
            (dataTemplatePath, objectDataURL(reader.swiftModelName)),       // Write CSoupObject
            (modelTemplatePath, modelURL(reader.swiftModelName))            // Write Model
            ]
        
        let outputURLs = filePaths.map({$0.1})
        
        if filesNeedGenerated(outputURLs) {
            for (template, outputURL) in filePaths {
                try writeFile(reader.swiftModelName, objectType: reader.objectType, soupName: reader.soupName, modelDescriptions: reader.modelDescriptionFields, templatePath: template, outputURL: outputURL)
            }
        } else {
            print("Files don't need generated for \(reader.swiftModelName)")
        }
    }
    
    
    
    // MARK: - Private API
    /*
     Return true if any of the outfiles don't exist or
     the input file mod date is newer than the mod date of
     an output file.
     */
    fileprivate func filesNeedGenerated(_ outputFiles: [URL]) -> Bool {
        var filesNeedGenerated = false
        
        guard let inputURLModDate = URL(fileURLWithPath: inputJSONPath).contentModificationDate() else {
            return true
        }

        filesNeedGenerated = outputFiles.index {
            guard let outputModDate = $0.contentModificationDate() else { return true }
            let inputIsNewer = ((inputURLModDate as NSDate).laterDate(outputModDate) == inputURLModDate)
            return inputIsNewer
        } != nil
        
        return filesNeedGenerated
    }
    
    fileprivate func writeFile(_ swiftModelName: String, objectType: String, soupName: String, modelDescriptions: [ModelDescriptionField], templatePath: String, outputURL: URL) throws {
        
        // Create template replacements
        var replacements = [String: AnyObject]();
        replacements["swiftModelName"] = swiftModelName as AnyObject
        replacements["objectType"] = objectType as AnyObject
        replacements["soupName"] = soupName as AnyObject
        replacements["modelDescriptions"] = modelDescriptions as AnyObject
        
        // Configure template engine
        let template = try String(contentsOfFile: templatePath)
        let renderer = DMTemplateEngine.engine(withTemplate: template) as! DMTemplateEngine
        
        // Add modifier to convert number to "true"/"false"
        renderer.addModifier("b".utf16.first!) { (content) -> String! in
            return content == "0" ? "false" : "true"
        }
        
        // Render the template
        let renderedText = renderer.renderAgainst(replacements)
        
        // Write the output file
        try renderedText?.write(to: outputURL, atomically: true, encoding: String.Encoding.utf8)
    }

    
    fileprivate func objectDataSpecURL(_ swiftModelName: String) -> URL {
        let url = URL(fileURLWithPath: outputDirectory, isDirectory: true)
            .appendingPathComponent("\(swiftModelName)SoupDescription")
            .appendingPathExtension("swift")
        
        return url
    }
    
    
    fileprivate func objectDataURL(_ swiftModelName: String) -> URL {
        let url = URL(fileURLWithPath: outputDirectory, isDirectory: true)
            .appendingPathComponent("\(swiftModelName)SoupObject")
            .appendingPathExtension("swift")
        return url
    }
    
    
    fileprivate func modelURL(_ swiftModelName: String) -> URL {
        let url = URL(fileURLWithPath: outputDirectory, isDirectory: true)
            .appendingPathComponent("\(swiftModelName)")
            .appendingPathExtension("swift")
        return url
    }
}

extension URL {
    
    func contentModificationDate() -> Date? {
        return (try? resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
    }
}
