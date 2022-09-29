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
    
    func fetchFontTable() -> Results<FontTable> {
        return localRealm.objects(FontTable.self)
    }
    
    func fetchCoinTable() -> Results<CoinTable> {
        return localRealm.objects(CoinTable.self)
    }
    
    func firstStartThema(item: ThemaTable) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print()
        }
    }
    
    func firstStartFont(item: FontTable) {
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
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: date), calender.startOfDay(for: date+86400))
        return item
    }
    
    func twoHourTimeFilter(date: Date) -> Results<UserTable> {
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", date, date+3600*2)
        return item
    }
    
    func dayTotalTimeFilter(date: Date) -> Int {
        let calender = Calendar.current
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", calender.startOfDay(for: date), calender.startOfDay(for: date+86400))
        let successToday = item.filter("Success == true")
        var successTotalTime = 0
        if successToday.isEmpty {
            return 0
        } else {
            for i in 0...successToday.count-1 {
                successTotalTime += successToday[i].SettingTime
            }
            return successTotalTime / 60
        }
        
    }
    
    func monthTotalTimeFilter(date: Date) -> Int {
        let setDate = date
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        let components = calendar.dateComponents([.year, .month], from: setDate)
        
        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: components)!
        
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
        
        
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", startOfMonth, nextMonth)
        print("asdasdasda",item)
        let successToday = item.filter("Success == true")
        var successTotalTime = 0
        if successToday.isEmpty {
            return 0
        } else {
            for i in 0...successToday.count-1 {
                successTotalTime += successToday[i].SettingTime
            }
            return successTotalTime / 60
        }
    }
    
    func monthCount(date: Date) -> Int {
        
        let setDate = date
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        let components = calendar.dateComponents([.year, .month], from: setDate)
        
        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: components)!
        
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
        
        
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", startOfMonth, nextMonth)
        let successMonth = item.filter("Success == true")
        return successMonth.count
    }
    
    func successfulRate() -> Int {
        let totalCount = localRealm.objects(UserTable.self).count
        let successCount = localRealm.objects(UserTable.self).filter("Success == true").count
        print("@@@@@@@@@",totalCount, successCount)
        let successRate:Double = (Double(successCount) / Double(totalCount)) * 100
        print(successRate)
        return Int(successRate)
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
    
    func FontBuy(item: FontTable, Fontlist: List<Bool>) {
        do {
            try localRealm.write {
                item.setValue(Fontlist, forKey: "Thema")
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
    
    func changeTFontBool(item: FontTable, fontNum: Int) {
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
            return 1
        case 60 * 30 :
            return 3
        case 60 * 60 :
            return 10
        case 60 * 120:
            return 30
        case 60 * 240:
            return 80
        case 60 * 480:
            return 200
        default:
            return 0
        }
    }
    
    
}
