//
//  Coin.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/25.
//

import Foundation
import RealmSwift

class CoinTable: Object {
    @Persisted var GetCoin : Int
    @Persisted var SpendCoin : Int
    @Persisted var Category: String
    
    init(GetCoin: Int) {
        self.GetCoin = GetCoin
        self.SpendCoin = 0
        self.Category = "완료"
    }
}
