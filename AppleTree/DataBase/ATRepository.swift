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
                localRealm.add(item)
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
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: Date()), calender.startOfDay(for: Date()+86400))
        return item
    }
    
    func dayFilter(date: Date) -> Results<UserTable> {
        let calender = Calendar.current
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: date), calender.startOfDay(for: Date()+86400))
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
        let item = todayFilter().filter("Success == true")
        return item
    }
    
    func dayTotalStudyTime(date: Date) -> Results<UserTable> {
        let item = dayFilter(date: date).filter("Success == true")
        return item
    }
    
    
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
    
    func changeThemaBool(item: ThemaTable, ThemaNum: Int) {
        do {
            try localRealm.write {
                item.Purchase = true
            }
        } catch {
            print()
        }
    }
    
    
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
