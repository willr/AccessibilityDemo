//
//  OrderedList.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/29/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class OrderedList: ContentList {
    
    override var reuseId: String {
        get {
            return BaseRow.OrderedListTypeName
        }
        set {
            self.reuseId = BaseRow.OrderedListTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        
        var i = 1
        for childRow in childRows {
            
            if let orderedRow = childRow as? OrderedRow {
                orderedRow.position = i
                i += 1
            }
        }
    }
}

