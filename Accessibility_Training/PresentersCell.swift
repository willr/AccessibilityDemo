//
//  PresentersCell.swift
//  Accessibility_Training
//
//  Created by Will Richardson on 10/3/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class PresentersCell: BaseTableViewCell {
    
    override func configure(rowModel: BaseRow) {
        
        super.configure(rowModel: rowModel)
        
    }
    
    func presentersModel() -> PresentersRow? {
        
        return baseRowModel as? PresentersRow
    }
}

