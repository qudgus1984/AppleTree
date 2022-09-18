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
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error 발생")
        }
    }
    
    func updateItem(item: AppleTree, appendTime: Int) {
        
//        var totalTime = item.ATTime
        var totalTime = item.ATTime
        totalTime += appendTime
        
        do {
            try localRealm.write {
                item.ATTime = totalTime
            }
        } catch {
            print()
        }
        print("저장되었습니다.", item.ATTime)
    }
    
    func todayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        return item
    }
    
    func yesterdayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
        return item
    }
    
    func appleTreeGrownCount() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATTime >= 21600")
        return item
    }
    
}
