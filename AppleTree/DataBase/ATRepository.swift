//
//  ATRepository.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/13.
//

import Foundation
import RealmSwift

protocol ATRepositoryType {
}

class ATRepository: ATRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetchUser() -> Results<UserTable> {
        return localRealm.objects(UserTable.self).sorted(byKeyPath: "StartTime", ascending: true)
    }
    
    func fetchThemaTable() -> Results<ThemaTable> {
        return localRealm.objects(ThemaTable.self)
    }
    
    func fetchCoinTable() -> Results<CoinTable> {
        return localRealm.objects(CoinTable.self)
    }
    
    func firstStart(item: ThemaTable) {
        do {
            try localRealm.write {
                [true, false, false, false, false].forEach {
                    item.Thema.append($0)
                }
            }
        } catch {
            print()
        }
    }
    
    func addItem(item: UserTable) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error 발생")
        }
    }
    
    func todayFilter() -> Results<UserTable> {
        let calender = Calendar.current
        var item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: Date()), calender.startOfDay(for: Date()+86400))
        return item
    }
    
    func yesterdayFilter() -> Results<UserTable> {
        let calender = Calendar.current
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: Date() - 86400), calender.startOfDay(for: Date()))
        return item
    }
    
    func totalCoin(item: Results<CoinTable>) -> Int {
        var total: Int = 0
        for i in 0...item.count - 1 {
            total += item[i].GetCoin
            total += item[i].SpendCoin
        }
        return total
    }
    
    func todayTotalStudyTime() -> Results<UserTable> {
        var item = todayFilter().filter("Success == true")
        return item
    }
    
//    func updateState(item: UserTable, Sucess: Bool) {
//        do {
//            try localRealm.write {
//                item.ATState = changeState
//                item.ATFinishTime = Date()
//                item.ATTotalCoin += coinCalculator()
//            }
//        } catch {
//            print()
//        }
//    }
    
    func updateState(item: UserTable, Sucess: Bool) {
        do {
            try localRealm.write {
                item.Success = true
                item.FinishTime = Date()
            }
        } catch {
            print()
        }
    }
    

    
    //    func updateItem(item: UserTable, appendTime: Int) {
    //
    //
    //
    //        do {
    //            try localRealm.write {
    //                item.SettingTime = SettingTim
    //            }
    //        } catch {
    //            print()
    //        }
    //    }
    //
    //    func todayFirstStartUpdateCoin(item: AppleTree, beforeAppleTree: AppleTree) {
    //        do {
    //            try localRealm.write {
    //                item.ATTotalCoin = beforeAppleTree.ATTotalCoin
    //            }
    //        } catch {
    //            print()
    //        }
    //    }
    //
    //    func updateState(item: AppleTree, State: Int) {
    //
    ////        var totalTime = item.ATTime
    //        var changeState = item.ATState
    //        changeState = State
    //
    //        do {
    //            try localRealm.write {
    //                item.ATState = changeState
    //                item.ATFinishTime = Date()
    //                item.ATTotalCoin += coinCalculator()
    //            }
    //        } catch {
    //            print()
    //        }
    //        print("저장되었습니다.", item.ATTime)
    //    }
    //
    //    func coinAppend(item: AppleTree, beforeItem: AppleTree) {
    //        do {
    //            try localRealm.write {
    //                item.ATTotalCoin += beforeItem.ATTotalCoin
    //            }
    //        } catch {
    //            print()
    //        }
    //    }
    //
    //    func coinState(item: AppleTree, beforeItem: AppleTree) {
    //        do {
    //            try localRealm.write {
    //                item.ATTotalCoin = beforeItem.ATTotalCoin
    //            }
    //        } catch {
    //            print()
    //        }
    //    }
    //
    //    func themaState(item: AppleTree, beforeItem: AppleTree) {
    //        do {
    //            try localRealm.write {
    //                item.ATThema = beforeItem.ATThema
    //            }
    //        } catch {
    //            print()
    //        }
    //    }
    //
    func themaBuy(item: ThemaTable, Themalist: List<Bool>) {
        do {
            try localRealm.write {
                item.setValue(Themalist, forKey: "Thema")
            }
        } catch {
            print()
        }
    }
    
    func addCoin(item: CoinTable) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error 발생")
        }
    }
    //
    ////    func SubtractCoin(item: AppleTree, Subtract: Int) {
    ////        do {
    ////            try localRealm.write {
    ////                item.ATTotalCoin - 2000
    ////
    ////            }
    ////        } catch {
    ////            print()
    ////        }
    ////    }
    //
    func changeThemaBool(item: ThemaTable, ThemaNum: Int) {
        do {
            try localRealm.write {
                item.Thema[ThemaNum] = true
            }
        } catch {
            print()
        }
    }
    //
    //    func todayFilter() -> Results<AppleTree> {
    //        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
    //        return item
    //    }
    //
    //    func yesterdayFilter() -> Results<AppleTree> {
    //        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
    //        return item
    //    }
    //
    //    func selectDayFilter(day: String) -> Results<AppleTree> {
    //        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(day)'" )
    //        return item
    //    }
    //
    //    func appleTreeGrownCount() -> Results<AppleTree> {
    //        let item = localRealm.objects(AppleTree.self).filter("ATTime >= 21600")
    //        return item
    //    }
    
    //    func todayTotalStudy() {
    //
    //    }
    
    
    func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 2000
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
