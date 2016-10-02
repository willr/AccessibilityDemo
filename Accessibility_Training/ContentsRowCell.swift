//
//  ContentsTableViewCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class ContentsRowCell: BaseTableViewCell {
    
    @IBOutlet var textContentsLabel: UILabel!
    
    override func configure(rowModel: BaseRow) {
        
        super.configure(rowModel: rowModel)
        
        if let contentRow = rowModel as? ContentRow {
            textContentsLabel.text = contentRow.textContents
            textContentsLabel.accessibilityLabel = contentRow.textContents
        }
        
    }
    
    func contentRowModel() -> ContentRow? {
        
        return baseRowModel as? ContentRow
    }
}
