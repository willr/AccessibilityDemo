//
//  BaseRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class BaseRow {

    static let HeaderTypeName = "heading"
    static let OrderedListTypeName = "ordered-list"
    static let OrderedRowTypeName = "ordered-row"
    static let SpacerTypeName = "spacer"
    static let UnorderedListTypeName = "unordered-list"
    static let UnorderedRowTypeName = "unordered-row"
    static let ParagraphTypeName = "paragraph"
    static let TitleTypeName = "title"
    static let PresentersTypeName = "presenters"

    static let TypeKeyName = "type"
    static let ChildrenKeyName = "children"
    static let ContentsKeyName = "contents"
    static let CustomIdKeyName = "customId"

    var type = RowType.Unknown
    var level = 0
    var childRows = [BaseRow]()
    var reuseId: String = "unknown"
    var visibleRow = false
    var customId: String = ""

    func parseJson(parsedJson: [String:Any], currLevel: Int) { // -> [String:Any]? {

        let rowTypeName = parsedJson[BaseRow.TypeKeyName] as! String
        type = ATDocument.parseRowType(rowTypeName: rowTypeName)
        level = currLevel
        customId = parsedJson[BaseRow.CustomIdKeyName] as! String

        if let children = parsedJson[BaseRow.ChildrenKeyName] as? [[String:Any]] {
            
            if children.count > 0 {
                
                for child in children {
                    
                    let rowJsonType = ATDocument.parseRowType(parsedJson: child)
                    let rowNode = ATDocument.newRowNode(rowType: rowJsonType)
                    rowNode.parseJson(parsedJson: child, currLevel: level + 1)
                    childRows.append(rowNode)
                }
            }
        }
        let _ = 0
        
    }

}
