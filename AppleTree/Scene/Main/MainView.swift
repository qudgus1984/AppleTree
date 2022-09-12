//
//  MainView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    var settingCount = 1800

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkGreen
        return view
    }()
    
    let famousSayingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "내일 지구가 멸망할지라도 나는 오늘 한 그루의 사과나무를 심겠다.\n-바뤼흐 스피노자-"
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 28)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 120
        view.backgroundColor = .white
        return view
    }()
    
    let countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 44)
        label.textAlignment = .center
        return label
    }()
    
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    // circle Progress Bar 도전!
    let circularProgressBar: CircularProgress = {
        let circularProgressBar = CircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: 255, height: 255))

        circularProgressBar.progressColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        circularProgressBar.trackColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 0.6)
        circularProgressBar.tag = 101

        return circularProgressBar
    }()
    
    
    override func configure() {
        [bgView, famousSayingLabel, circularProgressBar, iconImageView, countTimeLabel, startButton].forEach {
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
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        circularProgressBar.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.275)
            
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalTo(circularProgressBar).inset(safeAreaInsets).inset(8)
 
        }
        
        countTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-28)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(countTimeLabel.snp.bottom).offset(28)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        
        
    }
    

    
    
    
}
