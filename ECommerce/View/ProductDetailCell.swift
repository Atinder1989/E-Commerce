//
//  ProductDetailCell.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 30/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {

    @IBOutlet weak var colorLabel:        UILabel!
    @IBOutlet weak var sizeLabel:         UILabel!
    @IBOutlet weak var priceLabel:        UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
