//
//  UnorderedList.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/29/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class UnorderedList: ContentList {
    
    override var reuseId: String {
        get {
            return BaseRow.UnorderedListTypeName
        }
        set {
            self.reuseId = BaseRow.UnorderedListTypeName
        }
    }
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
    }
}
