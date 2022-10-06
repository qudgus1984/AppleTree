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
        case 401:
            return "몽환적 솜사탕 테마💜를 구입하셨습니다."
        case 402:
            return "달콤한 복숭아 테마🍑를 구입하셨습니다."
        case 403:
            return "감성적 밤하늘 테마🌌를 구입하셨습니다."
        case 404:
            return "시원한 바닷가 테마🏖를 구입하셨습니다."
        case 501:
            return "Gangwon 폰트🦋를 구입하셨습니다."
        case 502:
            return "LeeSeoyun 폰트✨를 구입하셨습니다."
        case 503:
            return "Simkyungha 폰트🌃를 구입하셨습니다."
        default:
            return "입력되지 않은 상태코드입니다."
            
        }
    }
}
