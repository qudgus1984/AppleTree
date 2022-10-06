//
//  TimeLineTableViewCell.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/05.
//

import UIKit
import SnapKit

class TimeLineTableViewCell: BaseTableViewCell {
    
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        DispatchQueue.main.async {
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
        }
        return view
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = themaChoice().progressColor
        DispatchQueue.main.async {
            view.clipsToBounds = true
            view.layer.cornerRadius = view.frame.width / 2
        }
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontChoice().Font24
        label.text = "explainLabel"
        return label
    }()
    
    let containExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontChoice().Font16
        label.text = "containExplainLabel"
        return label
    }()
    
    let statusExplainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontChoice().Font16
        label.text = "containExplainLabel"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [explainLabel, containView, iconImageView, containExplainLabel, statusExplainLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(60)
        }
        
        containView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.height.equalTo(300)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containView)
            make.centerY.equalTo(containView)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        containExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.bottom.equalTo(containView.snp.bottom).offset(-8)
            make.trailing.equalTo(containView.snp.trailing).offset(-8)
            make.leading.equalTo(containView.snp.leading).offset(8)
        }
        
        statusExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(containView.snp.top).offset(8)
            make.height.equalTo(30)
            make.trailing.equalTo(containView.snp.trailing).offset(-8)
            make.leading.equalTo(containView.snp.leading).offset(8)
        }
        
    }
    
}

