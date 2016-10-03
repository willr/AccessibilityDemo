//
//  OrderedRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class OrderedRow: ContentListRow {
    
    var position = 0
    
    override var reuseId: String {
        get {
            return BaseRow.OrderedRowTypeName
        }
        set {
            super.reuseId = BaseRow.OrderedRowTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) { // -> (parsedJson: [String:Any]?, level: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        
        let _ = 0
    }
}
