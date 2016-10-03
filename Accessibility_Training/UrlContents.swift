//
//  UrlContents.swift
//  Accessibility_Training
//
//  Created by Will Richardson on 10/1/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class UrlContents: StringContents {
    
    var link: URL? = URL(string:"")
    
    override var type: ContentsType {
        get {
            return ContentsType.URL
        }
        set {
            super.type = ContentsType.URL
        }
    }
    
    override func parseJson(parsedJson: [String:Any]) {
        
        super.parseJson(parsedJson: parsedJson)
        
        if let hasLink = parsedJson[BaseContents.LinkKeyName] as? String {
            let linkUrl = URL(string:hasLink)
            link = linkUrl
        }
    }
    
    override func toAttribString() -> NSAttributedString {
        
        let attributes = [NSLinkAttributeName: link]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
