//
//  BaseTableViewCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/26/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit


class BaseTableViewCell: UITableViewCell {
    
    var cellType = RowType.Unknown
    var cellLevel = 0
    
    var baseRowModel: BaseRow? = nil
    
    func configure(rowModel: BaseRow) {
        
        baseRowModel = rowModel
    }
    
}
