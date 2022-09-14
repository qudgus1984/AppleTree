//
//  ATRepository.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/13.
//

import Foundation
import RealmSwift

protocol ATRepositoryType {
    func fetch() -> Results<AppleTree>
    func addItem(item: AppleTree)
    func updateItem(item: AppleTree, appendTime: Int)
}

class ATRepository: ATRepositoryType {
        
    let localRealm = try! Realm()
    
    func fetch() -> Results<AppleTree> {
        return localRealm.objects(AppleTree.self).sorted(byKeyPath: "ATDate", ascending: true)
    }

    
    func addItem(item: AppleTree) {
        try! localRealm.write {
            localRealm.add(item)
        }
    }
    
    func updateItem(item: AppleTree, appendTime: Int) {
        try! localRealm.write {
            item.ATTime += appendTime
            print("시간이 추가되었습니다.", item.ATTime)

        }
    }
}
