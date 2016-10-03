//
//  ContentRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class ContentRow: BaseRow {
    
    var textContentsArray: [StringContents] = [StringContents]()
    
    override func parseJson(parsedJson: [String:Any], currLevel: Int) { // -> (parsedJson: [String:Any]?, level: Int) {
        
        super.parseJson(parsedJson: parsedJson, currLevel: currLevel)
        visibleRow = true
        
        let parsedJsonContentsArray = parsedJson[BaseRow.ContentsKeyName] as! [[String: Any]]
        
        for parsedJsonContents: [String: Any] in parsedJsonContentsArray {
            
            let contentsTypeString = parsedJsonContents[BaseContents.TypeKeyName] as! String
            let contentsType = ATDocument.parseContentsType(contentsTypeName: contentsTypeString)
            let newContents = ATDocument.newContentsType(contentsType: contentsType) as! StringContents
            newContents.parseJson(parsedJson: parsedJsonContents)
            
            textContentsArray.append(newContents)
        }
    }
    
    func toAttribString() -> NSAttributedString {
        
        let attribString: NSMutableAttributedString = NSAttributedString(string: "").mutableCopy() as! NSMutableAttributedString
        for content: StringContents in textContentsArray {
            
            attribString.append(content.toAttribString())
        }
        
        return attribString
    }
}
