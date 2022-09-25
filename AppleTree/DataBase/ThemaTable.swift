//
//  Thema.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/25.
//

import Foundation
import RealmSwift

class ThemaTable: Object {
    @Persisted var ThemaList: List<Bool> // 테마 관리
    @Persisted(primaryKey: true) var objectId: ObjectId

    
}
