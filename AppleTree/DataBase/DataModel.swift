//
//  DataModel.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/13.
//

import Foundation
import RealmSwift

//MARK: Model 구성

class AppleTree: Object {
    @Persisted var ATDate: String
    @Persisted var ATTime: Int

    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(ATDate: String, ATTime: Int) {
        self.init()
        self.ATTime = ATTime
        self.ATDate = ATDate
    }
}
