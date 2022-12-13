//
//  FontTable.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/28.
//

import Foundation
import RealmSwift

class FontTable: Object {
    @Persisted var FontName: String // 폰트 관리
    @Persisted var Purchase: Bool
    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(FontName: String, Purchase: Bool) {
        self.init()
        self.FontName = FontName
        self.Purchase = Purchase
    }
}
