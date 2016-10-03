//
//  Heading.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class HeadingRow: ContentRow {
    
    override var reuseId: String {
        get {
            return BaseRow.HeaderTypeName
        }
        set {
            super.reuseId = BaseRow.HeaderTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
    }
}
