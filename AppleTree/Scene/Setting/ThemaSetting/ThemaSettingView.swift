//
//  ThemaSettingView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/19.
//

import UIKit
import SnapKit

final class ThemaSettingView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = themaChoice().lightColor
        view.register(ThemaSettingTableViewCell.self, forCellReuseIdentifier: "cell")
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
