//
//  PresentersRow.swift
//  Accessibility_Training
//
//  Created by Will Richardson on 10/3/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class PresentersRow: BaseRow {
    
    override var reuseId: String {
        get {
            return BaseRow.PresentersTypeName
        }
        set {
            super.reuseId = BaseRow.PresentersTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        
        visibleRow = true
    }
}

