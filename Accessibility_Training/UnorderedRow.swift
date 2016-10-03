//
//  Unordered.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class UnorderedRow: ContentListRow {
    
    override var reuseId: String {
        get {
            return BaseRow.UnorderedRowTypeName
        }
        set {
            super.reuseId = BaseRow.UnorderedRowTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
    }
}
