//
//  DataModel.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/13.
//

import Foundation
import RealmSwift

//MARK: Model 구성

class UserTable: Object {

//     시작시간 : Date
     @Persisted var StartTime: Date
//     종료시간 : Date
     @Persisted var FinishTime: Date
//     세팅시간 : Int
     @Persisted var SettingTime: Int

    
//     성공 여부 : Bool
     @Persisted var Success: Bool
//     집중 모드 여부 : Bool
     @Persisted var ConcentrateMode: Bool
//     중지 버튼 횟수 : Int
     @Persisted var StopButtomClicked: Int
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    
    convenience init(SettingTime: Int) {
        self.init()
        self.StartTime = Date()
        self.Success = false
        self.ConcentrateMode = false
        self.SettingTime = SettingTime
        
    }

}
