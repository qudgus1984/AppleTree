//
//  Thema.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/25.
//

import Foundation
import RealmSwift

class ThemaTable: Object {
    @Persisted var ThemaName: String // 테마 관리
    @Persisted var Purchase: Bool
    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(ThemaName: String, Purchase: Bool) {
        self.init()
        self.ThemaName = ThemaName
        self.Purchase = Purchase
    }
}
