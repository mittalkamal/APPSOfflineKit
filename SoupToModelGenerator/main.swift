//
//  main.swift
//  SoupToModelGenerator
//
//  Created by Ken Grigsby on 1/10/16.
//  Copyright © 2016 Appstronomy. All rights reserved.
//

/*
 This is an application to generate model objects for use with Salesforce. The input is a JSON
 file specifying the object type, soup name, and an array of field descriptions.
 An example is:
 
 {
 "soupName": "accounts",
 "objectType": "Account",
 "fields": [
 {
 "name": "Id",
 "type": "string",
 "searchable": true
 },
 {
 "name": "Name",
 "type": "string",
 "searchable": true
 }
 ]
 }
 
 This application will generate three files for the example above:
 
 1. Account.swift
 2. AccountSoupObject.swift
 3. AccountSoupDescription.swift
 */

import Foundation

// Create the command line parser
let cli = CommandLine()

// Configure command line parser
let jsonFile              = StringOption(longFlag: "json",                required: true, helpMessage: "Path to the JSON input file.")
let specTemplateFile      = StringOption(longFlag: "spec-template",       required: true, helpMessage: "Path to the spec template input file.")
let dataTemplateFile      = StringOption(longFlag: "data-template",       required: true, helpMessage: "Path to the data template input file.")
let modelTemplateFile     = StringOption(longFlag: "model-template",      required: true, helpMessage: "Path to the model template input file.")
let outputDir             = StringOption(longFlag: "output-dir",          required: true, helpMessage: "Path to the output directory.")

cli.addOptions(jsonFile, specTemplateFile, dataTemplateFile, modelTemplateFile, outputDir)


// Parse the command line
do {
    try cli.parse(strict: true)
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

// Pass the command line arguments to the app
let app = SoupToModelGeneratorApplication(inputJSONPath: jsonFile.value!, specTemplatePath: specTemplateFile.value!, dataTemplatePath: dataTemplateFile.value!, modelTemplatePath: modelTemplateFile.value!, outputDirectory: outputDir.value!)
do {
    try app.start()
} catch let error as NSError {
    print(error.localizedDescription)
    exit(EXIT_FAILURE)
}
