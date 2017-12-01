//
//  Tax.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 29/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import Foundation

struct Tax : Decodable  {
    var name:             String
    var value:            Float
    
    enum TaxKeys: String, CodingKey {
        case name         = "name"
        case value        = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TaxKeys.self)
        self.name     = try container.decode(String.self,   forKey: .name)
        self.value    = try container.decode(Float.self, forKey: .value)
    }
}
