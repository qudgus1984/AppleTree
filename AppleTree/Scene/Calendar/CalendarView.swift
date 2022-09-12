//
//  CalendarView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import SnapKit

class CalendarView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemGray6
        view.register(CalendarTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func configure() {
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstants() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}

