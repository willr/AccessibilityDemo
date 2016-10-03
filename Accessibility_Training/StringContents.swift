//
//  StringContents.swift
//  Accessibility_Training
//
//  Created by Will Richardson on 10/1/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class StringContents: BaseContents {

    var text: String = ""
    
    override var type: ContentsType {
        get {
            return ContentsType.String
        }
        set {
            super.type = ContentsType.String
        }
    }
    
    override func parseJson(parsedJson: [String:Any]) {
        
        super.parseJson(parsedJson: parsedJson)
        
        if let hasText = parsedJson[BaseContents.TextKeyName] as? String {
            text = hasText
        }
    }
    
    func toAttribString() -> NSAttributedString {
        
        return NSAttributedString(string: text)
    }
}
