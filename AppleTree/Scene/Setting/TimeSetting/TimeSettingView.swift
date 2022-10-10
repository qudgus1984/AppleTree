//
//  TimeSettingView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit
import SnapKit

final class TimeSettingView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = themaChoice().lightColor
        view.register(TimeSettingTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    

    override func configure() {
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstants() {
 
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}

