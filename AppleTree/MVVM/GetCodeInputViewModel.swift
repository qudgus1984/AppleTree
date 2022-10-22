//
//  SettingViewModel.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/10.
//

import Foundation

struct GetCodeInputViewModel {
    
    var couponCode: Observable<String?> = Observable("")
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidation() -> Void {
        switch couponCode.value {
        case "SeSAC":
            return isValid.value = true
        case "concrete":
            return isValid.value = true
        case "growtime":
            return isValid.value = true
        default:
            return isValid.value = false
        }
    }
}
