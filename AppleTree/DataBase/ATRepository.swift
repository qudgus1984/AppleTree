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

    func firstStart(item: AppleTree) {
        do {
            try localRealm.write {
                [true, false, false, false, false].forEach {
                    item.ATThema.append($0)
                }
            }
        } catch {
            print()
        }
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
    
    func todayFirstStartUpdateCoin(item: AppleTree, beforeAppleTree: AppleTree) {
        do {
            try localRealm.write {
                item.ATTotalCoin = beforeAppleTree.ATTotalCoin
            }
        } catch {
            print()
        }
    }
    
    func updateState(item: AppleTree, State: Int) {
        
//        var totalTime = item.ATTime
        var changeState = item.ATState
        changeState = State

        do {
            try localRealm.write {
                item.ATState = changeState
                item.ATFinishTime = Date()
                item.ATTotalCoin += coinCalculator()
            }
        } catch {
            print()
        }
        print("저장되었습니다.", item.ATTime)
    }
    
    func coinAppend(item: AppleTree, beforeItem: AppleTree) {
        do {
            try localRealm.write {
                item.ATTotalCoin += beforeItem.ATTotalCoin
            }
        } catch {
            print()
        }
    }
    
    func coinState(item: AppleTree, beforeItem: AppleTree) {
        do {
            try localRealm.write {
                item.ATTotalCoin = beforeItem.ATTotalCoin
            }
        } catch {
            print()
        }
    }
    
    func themaState(item: AppleTree, beforeItem: AppleTree) {
        do {
            try localRealm.write {
                item.ATThema = beforeItem.ATThema
            }
        } catch {
            print()
        }
    }
    
    func themaBuy(item: AppleTree, Themalist: List<Bool>, Subtract: Int) {
        do {
            try localRealm.write {
                item.setValue(Themalist, forKey: "ATThema")
                item.setValue(Subtract, forKey: "ATTotalCoin")
            }
        } catch {
            print()
        }
    }
    
//    func SubtractCoin(item: AppleTree, Subtract: Int) {
//        do {
//            try localRealm.write {
//                item.ATTotalCoin - 2000
//
//            }
//        } catch {
//            print()
//        }
//    }
    
    func changeThemaBool(item: AppleTree, ThemaNum: Int) {
        do {
            try localRealm.write {
                item.ATThema[ThemaNum] = true
            }
        } catch {
            print()
        }
    }
    
    func todayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        return item
    }
    
    func yesterdayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
        return item
    }
    
    func selectDayFilter(day: String) -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(day)'" )
        return item
    }
    
    func appleTreeGrownCount() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATTime >= 21600")
        return item
    }
    
    
    

    
    
    func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 1
        case 60 * 30 :
            return 3
        case 60 * 60 :
            return 8
        case 60 * 120:
            return 20
        case 60 * 240:
            return 50
        case 60 * 480:
            return 120
        default:
            return 0
        }
    }
    

}
