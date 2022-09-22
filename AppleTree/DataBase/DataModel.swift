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
    @Persisted var ATDate: String // 필터링한 날짜
    @Persisted var ATTime: Int // 선택한 Time 시간
    
    @Persisted var ATStartTime: Date // 시작시간
    @Persisted var ATFinishTime: Date? // 끝낸시간
    @Persisted var ATState: Int
    
    /*
     시간 데이터 관련
     0 -> 오늘 처음 시작한 상태
     1 -> 성공
     2 -> 실패
     
     화면 전환 관련
     4 -> 설정테마 전환
     5 -> 설정시간 전환
     6 -> 테마 구입
     */
    
    @Persisted var ATTotalCoin: Int // 코인의 총 개수
    @Persisted var ATThema: List<Bool> // 테마 관리


    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(ATDate: String, ATTime: Int, ATState: Int) {
        self.init()
        self.ATTime = ATTime
        self.ATDate = ATDate
        self.ATState = ATState
        
    }
}
