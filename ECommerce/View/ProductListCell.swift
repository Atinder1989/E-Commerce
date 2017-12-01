//
//  ProductListCell.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 30/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!

    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        
    }
    
}
