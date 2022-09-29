//
//  ResetPopupView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/18.
//

import UIKit
import SnapKit

class ResetPopupView: BaseView {
    
    var settingCount = UserDefaults.standard.integer(forKey: "engagedTime")

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let famousSayingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "내일 지구가 멸망할지라도 나는 오늘 한 그루의 사과나무를 심겠다.\n-바뤼흐 스피노자-"
        label.font = FontChoice().Font24
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.size.width / 2
        }
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "appletreeDie")
        view.backgroundColor = .white
        return view
    }()
    
    let countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = FontChoice().Font36
        label.textAlignment = .center
        return label
    }()
    
    let buttonInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시", for: .normal)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    
    


    override func configure() {
        [bgView, famousSayingLabel, iconImageView, countTimeLabel, buttonInsetView, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        famousSayingLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(iconImageView.snp.width)
        }
        
        countTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-28)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        buttonInsetView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(countTimeLabel.snp.bottom).offset(28)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        startButton.snp.makeConstraints { make in
            make.edges.equalTo(buttonInsetView).inset(4)
        }

    }

}
