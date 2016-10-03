//
//  ContentList.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/29/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class ContentList: ContentRow {
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        visibleRow = true

        if childRows.count > 0 {
            
            let lastRow = childRows[childRows.count - 1] as! ContentListRow
            lastRow.lastListRow = true
        }
    }
}

