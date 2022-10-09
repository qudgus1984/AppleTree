//
//  CalendarViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import SnapKit
import FSCalendar
import RealmSwift

final class CalendarViewController: BaseViewController {
    
    var userTasks: Results<UserTable>! {
        didSet {
            mainview.calendarView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userTasks = repository.fetchUser()
        mainview.tableView.reloadData()
        
    }
    
    let repository = ATRepository()
    let mainview = CalendarView()
    let dateFormatter = DateFormatter()
    
    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendarUI()
        
        mainview.tableView.dataSource = self
        mainview.tableView.delegate = self
    }
    
    func setCalendarUI() {
        mainview.calendarView.dataSource = self
        mainview.calendarView.delegate = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let weekDictionary: [Int : String] = [0 : "일", 1 : "월", 2 : "화", 3 : "수", 4 : "목", 5 : "금", 6 : "토"]
        for i in 0...6 {
            mainview.calendarView.calendarWeekdayView.weekdayLabels[i].text = weekDictionary[i]
        }
        
        self.mainview.calendarView.appearance.weekdayFont = FontChoice().Font16
        self.mainview.calendarView.appearance.weekdayTextColor = themaChoice().mainColor.withAlphaComponent(0.9)
        self.mainview.calendarView.appearance.headerTitleFont = FontChoice().Font24
        self.mainview.calendarView.appearance.headerTitleColor = themaChoice().mainColor.withAlphaComponent(0.9)
        self.mainview.calendarView.appearance.headerTitleAlignment = .center
    }
    
    //이미지 크기 조절 메서드
    func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func configure() {
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = themaChoice().lightColor
        appearence.shadowColor = .clear

        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CalendarTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        
        

        
        
        
        if repository.yesterdayFilter().isEmpty {
            
            let hour = repository.dayTotalTimeFilter(date: Date()) / 60
            let minutes = repository.dayTotalTimeFilter(date: Date()) % 60
            
            switch indexPath.row {
            case 0:
                if hour == 0 {
                    cell.explainLabel.text = "오늘 \(minutes)분 만큼 성장하셨네요"
                } else {
                    cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
                }
                
            case 1:
                cell.explainLabel.text = "어제는 성장하지 않으셨군요!!"
                
            case 2:
                cell.explainLabel.text = "이번 달에는 \(repository.monthCount(date: Date()))번 성공하셨어요 👍🏻"
            default:
                print()
            }
            
        } else {
            
            let hour = repository.dayTotalTimeFilter(date: Date()) / 60
            let minutes = repository.dayTotalTimeFilter(date: Date()) % 60
            
            let removeNum = repository.dayTotalTimeFilter(date: Date()) - repository.dayTotalTimeFilter(date: Date() - 86400)
            let removehour = removeNum / 60
            let removeminutes = removeNum % 60
            
            switch indexPath.row {
            case 0:
                cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            case 1:
                if removeNum < 0 {
                    cell.explainLabel.text = "어제보다 \(-removehour)시간 \(-removeminutes)분 덜 했어요 😭"
                } else if removeNum > 0 {
                    cell.explainLabel.text = "어제보다 \(removehour)시간 \(removeminutes)분 더 나아갔어요!"
                } else {
                    cell.explainLabel.text = "한결같은 당신의 꾸준함을 응원합니다 :D"
                    
                }
            case 2:
                cell.explainLabel.text = "이번 달에는 \(repository.monthCount(date: Date()))번 성공하셨어요 👍🏻"
            default:
                print()
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {

        if repository.dayFilter(date: date).isEmpty {
            return nil
        } else {
            if repository.dayTotalStudyTime(date: date).isEmpty {
                return "0분"
            } else {
                var totalStudyTime = 0
                for i in 0...repository.dayTotalStudyTime(date: date).count - 1 {
                    totalStudyTime += repository.dayTotalStudyTime(date: date)[i].SettingTime
                }
                switch totalStudyTime/3600 {
                case 0:
                    return String("\(totalStudyTime%3600 / 60)분")
                default:
                    if totalStudyTime%3600 / 60 == 0 {
                        return String("\(totalStudyTime/3600)시간")
                    } else {
                        return String("\(totalStudyTime/3600):\(totalStudyTime%3600 / 60)")
                    }

                }
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        
    }
    
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        print(date)
        if repository.dayFilter(date: date).isEmpty {
            return nil
        } else {
            var totalStudyTime = 0
            if repository.dayTotalStudyTime(date: date).isEmpty {
                return resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
            } else {
                for i in 0...repository.dayTotalStudyTime(date: date).count - 1 {
                    totalStudyTime += repository.dayTotalStudyTime(date: date)[i].SettingTime
                }
                return dateChangedIcon(time: totalStudyTime)
            }
        }        
    }
    
    
    
    func dateChangedIcon(time: Int) -> UIImage? {
        let seedsImg = resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
        let sproutImg = resizeImage(image: UIImage(named: "sprout")!, width: 20, height: 20)
        let branchImg = resizeImage(image: UIImage(named: "blossom")!, width: 20, height: 20)
        let appleImg = resizeImage(image: UIImage(named: "apple")!, width: 20, height: 20)
        let appleTreeImg = resizeImage(image: UIImage(named: "apple-tree")!, width: 20, height: 20)
        
        switch time {
        case 0:
            return seedsImg
        case 1...7199:
            return sproutImg
        case 7200...14399:
            return branchImg
        case 14400...21599:
            return appleImg
        case 21600...:
            return appleTreeImg
        default:
            return nil
        }
        
        
    }
    
}
