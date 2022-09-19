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
//        view.backgroundColor = themaChoice().lightColor

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
        view.backgroundColor = themaChoice().mainColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        print("첫번째 icon 이미지 뷰를 만드는 장소")

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
//        button.backgroundColor = themaChoice().mainColor

        return button
    }()
    
    // circle Progress Bar 도전!
    
    let circularProgressBar: CircularProgress = {

        
        let circularProgressBar = CircularProgress(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6))
        
        circularProgressBar.progressColor = themaChoice().progressColor
        circularProgressBar.trackColor = themaChoice().lightColor
        circularProgressBar.tag = 101
        print("세번째 프로그래스바를 다 만들었음")
        return circularProgressBar
    }()

    override func configure() {

        
        [bgView, famousSayingLabel, iconImageView, circularProgressBar, countTimeLabel, startButton, stopCountLabel].forEach {
            self.addSubview($0)
        }
//        [bgView, famousSayingLabel, countTimeLabel, startButton, stopCountLabel].forEach {
//            self.addSubview($0)
//        }
//        addSubview(circularProgressBar)
//        print("서큘레이터그렸꾸우")
//        addSubview(iconImageView)
//        print("아이콘을 그려따")
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
            make.edges.equalTo(circularProgressBar).inset(safeAreaInsets).inset(20)
 
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
