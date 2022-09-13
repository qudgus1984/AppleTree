//
//  CalendarView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .huntLightGreen
        view.register(CalendarTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    let calendarView: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .huntLightGreen
        view.appearance.selectionColor = .customDarkGreen
        view.appearance.todayColor = .huntGreen
        return view
    }()
    
    override func configure() {
        [calendarView,tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstants() {
        
        calendarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(calendarView.snp.bottom)
        }
    }
    
}

