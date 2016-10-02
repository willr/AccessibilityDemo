//
//  ParagraphRow.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import Foundation

class ParagraghRow: ContentRow {
    
    override var reuseId: String {
        get {
            return BaseRow.ParagraphTypeName
        }
        set {
            self.reuseId = BaseRow.ParagraphTypeName
        }
    }
    
}
