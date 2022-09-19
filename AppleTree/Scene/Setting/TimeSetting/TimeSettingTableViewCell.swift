//
//  TimeSettingTableViewCell.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit
import SnapKit

class TimeSettingTableViewCell: BaseTableViewCell {
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 22)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [containView, explainLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        containView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(4)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

