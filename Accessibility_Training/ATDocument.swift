//
//  ATDocument.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

enum RowType {
    case Header
    case OrderedList
    case OrderedRow
    case Paragraph
    case UnorderedList
    case UnorderedRow
    case Spacer
    case Title
    case Unknown
}

enum ContentsType {
    case String
    case URL
    case Unknown
}

class ATDocument {
    
    var rowNodes = [BaseRow]()
    var rowListBySection = [Int: [BaseRow]]()
    var headings = [HeadingRow]()
    var title: String = ""
    
    static func documentFromBundle() -> ATDocument {
        
        let doc = ATDocument()
        var title: String = ""
        
        guard let url = Bundle.main.url(forResource: "table_details", withExtension: "json") else {
            return doc
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]  else {
                return doc
            }
            
            guard let rowJsons = rootObject[BaseRow.ChildrenKeyName] as? [[String: AnyObject]] else {
                return doc
            }
            
            for rowJson in rowJsons {
                
                let rowJsonType = ATDocument.parseRowType(parsedJson: rowJson)
                if (rowJsonType == RowType.Title) {
                    let contentsArray = rowJson[BaseRow.ContentsKeyName] as! [[String: Any]]
                    let attributedTitle = NSMutableAttributedString(string: "")
                    for contents in contentsArray {
                        
                        let tempStringContents = StringContents()
                        tempStringContents.parseJson(parsedJson: contents)
                        attributedTitle.append(tempStringContents.toAttribString())
                    }
                    title = attributedTitle.string
                    continue
                }
                let rowNode = ATDocument.newRowNode(rowType: rowJsonType)
                rowNode.parseJson(parsedJson: rowJson, currLevel: 1)
                doc.rowNodes.append(rowNode)
            }
            
            var sectionCount = 0
            for rowNode in doc.rowNodes {
                
                let nodes = walkNoHeadingNodes(rowNode: rowNode)
                doc.rowListBySection[sectionCount] = nodes
                sectionCount += 1
            }
            
            for rowNode in doc.rowNodes {
                
                if (rowNode.type == RowType.Header) {
                    doc.headings.append(rowNode as! HeadingRow)
                }
                
                doc.headings.append(contentsOf: walkHeadingNodes(rowNode: rowNode))
            }
            
            doc.title = title
            let _ = title.characters.count
            let _ = 0
            
        } catch {
            return doc
        }
        
        return doc
    }
    
    static func walkNodes(rowNode: BaseRow) -> [BaseRow] {
        
        var nodeList = [BaseRow]()
        
        for childNode in rowNode.childRows {
            
            nodeList.append(childNode)
            nodeList.append(contentsOf: walkNodes(rowNode: childNode))
        }
        
        return nodeList
    }
    
    static func walkNoHeadingNodes(rowNode: BaseRow) -> [BaseRow] {
        
        var nodeList = [BaseRow]()
        
        for childNode in rowNode.childRows {
            
            if (childNode.type != RowType.Header) {
                nodeList.append(childNode)
            }
            nodeList.append(contentsOf: walkNodes(rowNode: childNode))
        }
        
        return nodeList
    }
    
    static func walkHeadingNodes(rowNode: BaseRow) -> [HeadingRow] {
        
        var nodeList = [HeadingRow]()
        
        for childNode in rowNode.childRows {
            
            if (childNode.type == RowType.Header) {
                nodeList.append(childNode as! HeadingRow)
            }
            
            nodeList.append(contentsOf: walkHeadingNodes(rowNode: childNode))
        }
        
        return nodeList
    }

    static func parseRowType(parsedJson: [String:Any]) -> RowType {

        var inferredRowType: RowType
        if let jsonType = parsedJson[BaseRow.TypeKeyName] {
            inferredRowType = parseRowType(rowTypeName: jsonType as! String)
        } else {
            inferredRowType = RowType.Unknown
        }

        return inferredRowType
    }

    static func parseRowType(rowTypeName: String) -> RowType {

        var inferredRowType: RowType
        switch rowTypeName {
        case BaseRow.HeaderTypeName:
            inferredRowType = RowType.Header
        case BaseRow.OrderedListTypeName:
            inferredRowType = RowType.OrderedList
        case BaseRow.OrderedRowTypeName:
            inferredRowType = RowType.OrderedRow
        case BaseRow.UnorderedListTypeName:
            inferredRowType = RowType.UnorderedList
        case BaseRow.UnorderedRowTypeName:
            inferredRowType = RowType.UnorderedRow
        case BaseRow.SpacerTypeName:
            inferredRowType = RowType.Spacer
        case BaseRow.ParagraphTypeName:
            inferredRowType = RowType.Paragraph
        case BaseRow.TitleTypeName:
            inferredRowType = RowType.Title
        default:
            inferredRowType = RowType.Unknown
        }

        return inferredRowType
    }

    static func newRowNode(rowType: RowType) -> BaseRow {

        let row: BaseRow

        switch rowType {
        case RowType.Header:
            row = HeadingRow()
        case RowType.OrderedList:
            row = OrderedList()
        case RowType.OrderedRow:
            row = OrderedRow()
        case RowType.Paragraph:
            row = ParagraghRow()
        case RowType.Spacer:
            row = SpacerRow()
        case RowType.UnorderedList:
            row = UnorderedList()
        case RowType.UnorderedRow:
            row = UnorderedRow()
        default:
            row = BaseRow()
        }

        return row
    }
    
    static func parseContentsType(contentsTypeName: String) -> ContentsType {
        
        var inferredType: ContentsType
        
        switch contentsTypeName {
        case BaseContents.StringContentsTypeName:
            inferredType = ContentsType.String
        case BaseContents.UrlContentsTypeName:
            inferredType = ContentsType.URL
        default:
            inferredType = ContentsType.Unknown
        }
        
        return inferredType
    }
    
    static func newContentsType(contentsType: ContentsType) -> BaseContents {
        
        let contents: BaseContents
        
        switch contentsType {
        case ContentsType.String:
            contents = StringContents()
        case ContentsType.URL:
            contents = UrlContents()
        default:
            contents = BaseContents()
        }
        
        return contents
    }
}
