//
//  CalendarViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarViewController: BaseViewController {
    
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
        mainview.calendarView.calendarWeekdayView.weekdayLabels[0].text = "일"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[1].text = "월"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[2].text = "화"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[3].text = "수"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[4].text = "목"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[5].text = "금"
        mainview.calendarView.calendarWeekdayView.weekdayLabels[6].text = "토"
    }
    

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CalendarTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "오늘" // realm 데이터
        default:
            return nil
        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
