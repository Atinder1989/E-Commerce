//
//  Rankings.swift
//  ECommerce
//
//  Created by Atinderpal Singh on 29/11/17.
//  Copyright © 2017 Abc. All rights reserved.
//

import Foundation

struct Rankings : Decodable  {
    var ranking:                   String
    var productRankList:           [ProductRank]
    
    enum RankingsKeys: String, CodingKey {
        case ranking                     = "ranking"
        case products                    = "products"
    }
    
    init(from decoder: Decoder) throws {
        let container        = try decoder.container(keyedBy: RankingsKeys.self)
        self.ranking         = try container.decode(String.self, forKey: .ranking)
        self.productRankList = try container.decode([ProductRank].self, forKey: .products)
    }
}
