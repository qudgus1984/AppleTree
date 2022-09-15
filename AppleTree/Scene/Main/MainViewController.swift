//
//  MainViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit

class MainViewController: BaseViewController {
    
    var startButtonBool: Bool = true
    var timer: Timer?
    var progress: Float = 0.0
    
    let mainview = MainView()
    let repository = ATRepository()


    override func viewDidLoad() {
        super.viewDidLoad()
        startButtonClicked()
        print(progress)
        
        mainview.iconImageView.image = UIImage(named: "apple")

        let todayInfo = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        mainview.iconImageView.image =  ChangedImage(time: todayInfo[0].ATTime)
        
        
        
    }
    
    
    override func loadView() {
        super.view = mainview
    }
    
    override func configure() {
        
        
        let minutes = self.mainview.settingCount / 60
        let seconds = self.mainview.settingCount % 60
        self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .huntGreen
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
        
        //MARK: Nav 바 버튼 관련
        let calenderButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calenderButtonClicked))
        calenderButton.tintColor = .white
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "lightbulb"), style: .plain, target: self, action: #selector(bulbButtonClicked))
        settingButton.tintColor = .white
        let bulbButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(settingButtonClicked))
        bulbButton.tintColor = .white
        navigationItem.leftBarButtonItems = [calenderButton]
        navigationItem.rightBarButtonItems = [bulbButton, settingButton]
    }
    
    @objc func calenderButtonClicked() {
        let vc = CalendarViewController()
//        vc.repository.fetch()
//        vc
        vc.tasks = vc.repository.fetch()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func bulbButtonClicked() {
        
    }
    
    func startButtonClicked() {
        
        mainview.startButton.addTarget(self, action: #selector(startButtonClickedCountDown), for: .touchUpInside)
        
    }
    
    @objc func startButtonClickedCountDown() {
        
        if startButtonBool == true {
            startButtonBool.toggle()
            self.mainview.startButton.setTitle("중지", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (t) in
                self.mainview.settingCount -= 1
                let minutes = self.mainview.settingCount / 60
                let seconds = self.mainview.settingCount % 60
                
                if self.mainview.settingCount > 0 {
                    self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                    self.mainview.countTimeLabel.text = "\(minutes):\(seconds)"
                    self.progress = Float(self.mainview.settingCount) / 1800.0
                    print(self.progress)
                    self.mainview.circularProgressBar.setProgressWithAnimation(duration: 0.0001, value: 1.0 - self.progress)
 
                    
                } else {
                    self.mainview.countTimeLabel.text = "00:00"
                    self.mainview.startButton.setTitle("완료", for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                    self.finishPopupVCAppear()
                    self.mainview.settingCount = 1800
                    self.mainview.countTimeLabel.text = "30:00"
                    
                }
            }
        } else {
            startButtonBool.toggle()
            self.mainview.startButton.setTitle("시작", for: .normal)
            timer?.invalidate()
            timer = nil
            
        }
        
    }
    
    func finishPopupVCAppear() {
        let vc = FinishPopupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsDirectory)

    }
    
    func ChangedImage(time: Int) -> UIImage? {
        
        
        let seedsImg = UIImage(named: "seeds")
        let sproutImg = UIImage(named: "sprout")
        let appleImg = UIImage(named: "apple")
        let appleTreeImg = UIImage(named: "apple-tree")!
        
        switch time {
        case 0...200:
            return seedsImg
        case 201...410:
            return sproutImg
        case 411...511:
            return appleImg
        case 512...6400:
            return appleTreeImg
        default:
            return nil
        }
    }
    
}
