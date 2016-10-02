//
//  OrderedListCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/26/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class OrderedListCell: ContentsListCell {
 
    override func configure(rowModel: BaseRow) {
        
        if rowModel is ContentList {
            super.configure(rowModel: rowModel)
        }
        
        if let orderedList = rowModel as? OrderedList {
            let itemCount = orderedList.childRows.count
            self.accessibilityLabel = self.textContentsLabel.text! + ". Ordered list of \(itemCount) items."
        }
    }
    
    func orderedListModel() -> OrderedList? {
        
        return baseRowModel as? OrderedList
    }
}

