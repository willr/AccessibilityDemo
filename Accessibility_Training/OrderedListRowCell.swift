//
//  OrderedListRowCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/29/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class OrderedListRowCell: ContentsRowCell {
    
    override func configure(rowModel: BaseRow) {
        
        if rowModel is ContentRow {
            super.configure(rowModel: rowModel)
        }
        
        if let orderedRow = rowModel as? OrderedRow {
            
            var spacer = ""
            for _ in 1...orderedRow.level {
                spacer.append(" ")
            }
            let level = orderedRow.position
            // let content = orderedRow.textContents
            // textContentsLabel.text = "\(spacer) \(level)) \(content)"
            let attribString = NSMutableAttributedString(string:"\(spacer) \(level) ")
            attribString.append(textContentsLabel.attributedText!)
            textContentsLabel.attributedText = attribString
            
            if orderedRow.lastListRow {
                self.accessibilityValue = "List End"
            }
        }
    }
    
    func orderedRowModel() -> OrderedRow? {
        
        return baseRowModel as? OrderedRow
    }
}
