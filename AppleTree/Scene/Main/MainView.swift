//
//  MainView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkGreen
        return view
    }()
    
    let famousSayingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "내일 지구가 멸망하더라도 나는 한 그루의 사과나무를 심겠다."
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    let countTimeLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .white
        return label
    }()
    
    
    let startButton: UIButton = {
        let button = UIButton()
        button.tintColor = .green
        return button
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .white
        label.text = "시작"
        return label
    }()
    
    override func configure() {
        [bgView, famousSayingLabel, iconImageView, countTimeLabel, startButton, startLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        famousSayingLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.height.equalTo(44)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(bgView)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.3)
            
        }
    }
    
    
    
}
