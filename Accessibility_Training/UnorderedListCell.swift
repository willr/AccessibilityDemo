//
//  UnorderedListCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/26/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class UnorderedListCell: ContentsListCell {
 
    override func configure(rowModel: BaseRow) {
        
        if rowModel is ContentList {
            super.configure(rowModel: rowModel)
        }
        
        if let unorderedList = rowModel as? UnorderedList {
            let itemCount = unorderedList.childRows.count
            self.textContentsLabel.accessibilityLabel = self.textContentsLabel.text! + ". List of \(itemCount) items."
        }

    }
    
    func unorderedListModel() -> UnorderedList? {
        
        return baseRowModel as? UnorderedList
    }
}
