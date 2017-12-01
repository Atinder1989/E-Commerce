//
//  ProductRank.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 29/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import Foundation

struct ProductRank : Decodable  {
    var id:                   Int
    var view_count:           Int?
    
    enum ProductRankKeys: String, CodingKey {
        case id                     = "id"
        case viewcount              = "view_count"
        case shares                 = "shares"
        case ordercount             = "order_count"

    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: ProductRankKeys.self)
        self.id          = try container.decode(Int.self, forKey: .id)
        self.view_count  = try container.decodeIfPresent(Int.self, forKey: .viewcount) ?? (container.decodeIfPresent(Int.self, forKey: .shares) ?? container.decodeIfPresent(Int.self, forKey: .ordercount))
        
        
        
    }
}
