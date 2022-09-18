//
//  MainView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    var settingCount = UserDefaults.standard.integer(forKey: "engagedTime")
    var stopCount = UserDefaults.standard.integer(forKey: "stop")

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .huntGreen
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
        DispatchQueue.main.async {
            view.layer.cornerRadius = view.frame.size.width / 2
        }
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "seeds")
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
    
    let stopCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.backgroundColor = .huntLightGreen
        return button
    }()
    
    // circle Progress Bar 도전!
    let circularProgressBar: CircularProgress = {

        let circularProgressBar = CircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6))
        
        circularProgressBar.progressColor = .huntYellow
        circularProgressBar.trackColor = .huntLightGreen
        circularProgressBar.tag = 101

        return circularProgressBar
    }()

    override func configure() {
        [bgView, famousSayingLabel, circularProgressBar, iconImageView, countTimeLabel, startButton, stopCountLabel].forEach {
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
        
        circularProgressBar.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(circularProgressBar.snp.width)
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
        
        stopCountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(startButton.snp.bottom).offset(0)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(countTimeLabel.snp.bottom).offset(12)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.05)
        }

    }

}
