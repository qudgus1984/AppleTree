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
        view.backgroundColor = themaChoice().mainColor
        return view
    }()
    
    let famousSayingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 24)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "seeds")
        view.backgroundColor = themaChoice().mainColor


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
        button.backgroundColor = themaChoice().lightColor

        return button
    }()
    
    // circle Progress Bar 도전!
    
    let circularProgressBar: CircularProgress = {

        
        let circularProgressBar = CircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.width * 0.65))
        
        circularProgressBar.progressColor = themaChoice().progressColor
        circularProgressBar.trackColor = themaChoice().lightColor
        circularProgressBar.tag = 101
        return circularProgressBar
    }()
    
    let containCoinView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let insetCoinView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().lightColor
        return view
    }()
    
    let totalCoinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "UhBee BEOJJI Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "8888"
       return label
    }()
    
    let coinImgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "dollar")
        return view
    }()
    
    
    

    override func configure() {

        
        [bgView, famousSayingLabel, iconImageView, circularProgressBar, countTimeLabel, startButton, stopCountLabel, containCoinView, insetCoinView, totalCoinLabel, coinImgView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        famousSayingLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        
        circularProgressBar.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(circularProgressBar.snp.width)
            
        }

        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(famousSayingLabel.snp.bottom).offset(4)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(circularProgressBar.snp.width)


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
        
        containCoinView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalToSuperview().multipliedBy(0.20)
        }
        insetCoinView.snp.makeConstraints { make in
            make.edges.equalTo(containCoinView).inset(4)
        }
        coinImgView.snp.makeConstraints { make in
            make.leading.top.equalTo(containCoinView)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalTo(coinImgView.snp.height)
        }
        
        totalCoinLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImgView).offset(30)
            make.top.trailing.bottom.equalTo(insetCoinView)
        }
        
        

    }

}
