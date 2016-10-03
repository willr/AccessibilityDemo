//
//  ContentsListCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/29/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit

class ContentsListCell: ContentsRowCell {
    
    override func configure(rowModel: BaseRow) {
        
        super.configure(rowModel: rowModel)
        
    }
    
    func contentListModel() -> ContentList? {
        
        return baseRowModel as? ContentList
    }
}
