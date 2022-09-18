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

class CalendarViewController: BaseViewController {
    
    var tasks: Results<AppleTree>! {
        didSet {
            mainview.calendarView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks = repository.fetch()
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
        appearence.backgroundColor = .huntLightGreen
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
        cell.backgroundColor = .huntLightGreen
        
        if repository.yesterdayFilter().isEmpty {
            
            let hour = repository.todayFilter()[0].ATTime / 3600
            let minutes = repository.todayFilter()[0].ATTime % 3600 / 60
            
            switch indexPath.row {
            case 0:
                cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            case 1:
                cell.explainLabel.text = "어제는 성장하지 않으셨군요!!"

            case 2:
                cell.explainLabel.text = "지금까지 성장시킨 사과나무는 총 \(repository.appleTreeGrownCount().count)개 입니다."
            default:
                print()
            }
            
        } else {
            
            let hour = repository.todayFilter()[0].ATTime / 3600
            let minutes = repository.todayFilter()[0].ATTime % 3600 / 60

            let removeNum = repository.todayFilter()[0].ATTime - repository.yesterdayFilter()[0].ATTime
            let removehour = removeNum / 3600
            let removeminutes = removeNum % 3600 / 60
            
            switch indexPath.row {
            case 0:
                cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
            case 1:
                if removeNum < 0 {
                    cell.explainLabel.text = "어제보다 \(-removehour)시간 \(-removeminutes)분 덜 했어요 😭"
                } else if removeNum > 0 {
                    cell.explainLabel.text = "어제보다 \(removehour)시간 \(removeminutes)분 더 나아갔어요! >_<"
                } else {
                    cell.explainLabel.text = "한결같은 당신의 꾸준함을 응원합니다 :D"

                }
            case 2:
                cell.explainLabel.text = "지금까지 성장시킨 사과나무는 총 \(repository.appleTreeGrownCount().count)개 입니다."
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let test = tasks.filter ( "ATDate == '\(dateFormatter.string(from: date))'")
        return test.isEmpty ? nil : String("\(test[0].ATTime/3600):\(test[0].ATTime%3600 / 60)")
    }

    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        print(date)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let filterData = tasks.filter ( "ATDate == '\(dateFormatter.string(from: date))'")
        return filterData.isEmpty ? UIImage() : dateChangedIcon(time: filterData[0].ATTime)

    }
    
    func dateChangedIcon(time: Int) -> UIImage? {
        let seedsImg = resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
        let sproutImg = resizeImage(image: UIImage(named: "sprout")!, width: 20, height: 20)
        let appleImg = resizeImage(image: UIImage(named: "apple")!, width: 20, height: 20)
        let appleTreeImg = resizeImage(image: UIImage(named: "apple-tree")!, width: 20, height: 20)
        
        switch time {
        case 0...7199:
            return seedsImg
        case 7200...14399:
            return sproutImg
        case 14400...21599:
            return appleImg
        case 21600...:
            return appleTreeImg
        default:
            return nil
        }
    }
}
