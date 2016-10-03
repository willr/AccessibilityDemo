//
//  BaseContents.swift
//  Accessibility_Training
//
//  Created by Will Richardson on 10/1/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class BaseContents {
    
    static let StringContentsTypeName = "string"
    static let UrlContentsTypeName = "url"
    
    static let TypeKeyName = "type"
    static let TextKeyName = "text"
    static let LinkKeyName = "link"
    
    var type: ContentsType = ContentsType.Unknown
    
    func parseJson(parsedJson: [String:Any]) {
        
        let contentsTypeString = parsedJson[BaseContents.TypeKeyName] as! String
        type = ATDocument.parseContentsType(contentsTypeName: contentsTypeString)
    }
}
