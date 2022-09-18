//
//  MainViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {
    
    
    var getSettingTime: [Int] = []
    
    var startButtonBool: Bool = true
    var timer: Timer?
    var progress: Float = 0.0
    
    let mainview = MainView()
    let repository = ATRepository()
    
    // 값 전달을 위한 fetch
    var tasks: Results<AppleTree>! {
        didSet {
            tasks = repository.fetch()
//            let todayInfo = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
            updateImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayRealmNotSet()
        
//        repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0))
        
        startButtonClicked()
        print(progress)
        
        mainview.iconImageView.image = UIImage(named: "seeds")
    }
    
    //값 전달을 위한 fetch
    override func viewWillAppear(_ animated: Bool) {
        tasks = repository.fetch()
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
                    self.progress = Float(self.mainview.settingCount) / Float(UserDefaults.standard.integer(forKey: "engagedTime"))
                    print(self.progress)
                    self.mainview.circularProgressBar.setProgressWithAnimation(duration: 0.00001, value: 1.0 - self.progress)
                    
                    
                } else {
                    self.mainview.countTimeLabel.text = "00:00"
                    self.mainview.startButton.setTitle("완료", for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                    self.finishPopupVCAppear()
                    self.mainview.settingCount = UserDefaults.standard.integer(forKey: "engagedTime")
                    let minutes = self.mainview.settingCount / 60
                    let seconds = self.mainview.settingCount % 60
                    self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
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
    
    func updateImage() {

        mainview.iconImageView.image =  ChangedImage(time: repository.todayFilter()[0].ATTime)
    }
    
    func ChangedImage(time: Int) -> UIImage? {
        
        
        switch time {
        case 0...7199:
            return UIImage(named: "seeds")
        case 7200...14399:
            return UIImage(named: "sprout")
        case 14400...21599:
            return UIImage(named: "apple")
        case 21600...:
            return UIImage(named: "apple-tree")
        default:
            return nil
        }
        
    }
    
    func todayRealmNotSet() {
        
        if repository.todayFilter().isEmpty {
            repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: mainview.settingCount))
        }
    }
}

extension MainViewController: settingTimeDelegate {
    func sendSettingTime(_ time: Int) {
        getSettingTime.append(time)
        mainview.settingCount = getSettingTime.startIndex
    }
}
