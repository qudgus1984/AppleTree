
//
//  Observable.swift
//  SeSACWeek9
//
//  Created by 이병현 on 2022/08/31.
//

import Foundation

final class Observable<T> { // 양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}

