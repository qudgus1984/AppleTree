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
    @Persisted var Status: Int
    @Persisted var now: Date
    @Persisted(primaryKey: true) var objectId: ObjectId

    
    convenience init(GetCoin: Int, SpendCoin: Int, Status: Int) {
        self.init()
        self.GetCoin = GetCoin
        self.SpendCoin = SpendCoin
        self.Status = Status
        self.now = Date()
    }
}
