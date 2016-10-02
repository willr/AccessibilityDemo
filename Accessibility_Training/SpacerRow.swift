//
//  Spacer.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class SpacerRow: BaseRow {
 
    override var reuseId: String {
        get {
            return BaseRow.SpacerTypeName
        }
        set {
            self.reuseId = BaseRow.SpacerTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        visibleRow = true
    }
    
}
