//
//  StatusLogic.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/26.
//

import Foundation

// 100 -> 성공
class StatusLogic {
    
    private init() {}
    
    func statusLogicFunc(status: Int) -> String {
        switch status {
        case 100:
            return "처음 출석하셨습니다."
        case 101:
            return "정해진 시간을 완료하셨습니다."
        default:
            return "입력되지 않은 상태코드입니다."
            
        }
    }
}
