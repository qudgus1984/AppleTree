//
//  ThemaSettingTableViewCell.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/19.
//

import UIKit
import SnapKit

final class ThemaSettingTableViewCell: BaseTableViewCell {
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontChoice().Font24
        label.textAlignment = .center
        return label
    }()
    
    let lockImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemGray3
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [containView, explainLabel, lockImageView].forEach {
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
        
        lockImageView.snp.makeConstraints { make in
            make.trailing.equalTo(containView.snp.trailing).offset(-20)
            make.centerY.equalTo(explainLabel)
            make.height.equalTo(containView.snp.height).multipliedBy(0.5)
            make.width.equalTo(lockImageView.snp.height)
            
        }
    }
    
}


