//
//  ContentRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class ContentRow: BaseRow {
    
    var textContents: String = ""
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) { // -> (parsedJson: [String:Any]?, level: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        visibleRow = true
        
        textContents = parsedJson[BaseRow.ContentsKeyName] as! String
    }
}
