//
//  ContentListRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 10/1/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

class ContentListRow: ContentRow {
    
    var lastListRow: Bool = false
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) { // -> (parsedJson: [String:Any]?, level: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
    }
}
