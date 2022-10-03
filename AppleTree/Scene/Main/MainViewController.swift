//
//  MainViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit
import RealmSwift
import Toast

class MainViewController: BaseViewController {
    
    
    var getSettingTime: [Int] = []
    
    var startButtonBool: Bool = true
    var timer: Timer?
    var progress: Float = 0.0
    
    var hiddenCount = 0
    
    let mainview = MainView()
    let repository = ATRepository()
    
    var firstStartButtonClicked = true
    
    var bulbBool = true
    
    
    
    // 값 전달을 위한 fetch
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
            updateImage()
        }
    }
    
    var coinTasks: Results<CoinTable>! {
        didSet {
            coinTasks = repository.fetchCoinTable()
        }
    }
    
    var themaTasks: Results<ThemaTable>! {
        didSet {
            themaTasks = repository.fetchThemaTable()
        }
    }
    
    var fontTasks: Results<FontTable>! {
        didSet {
            fontTasks = repository.fetchFontTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames {
            print(family)
            
            for sub in UIFont.fontNames(forFamilyName: family) {
                print("====> \(sub)")
            }
        }
        
        UserDefaults.standard.set(UIScreen.main.brightness, forKey: "bright")
        coinTasks = repository.fetchCoinTable()
        if coinTasks.isEmpty {
            repository.addCoin(item: CoinTable(GetCoin: 10, SpendCoin: 0, Status: 100))
        }
        themaTasks = repository.fetchThemaTable()
        if themaTasks.isEmpty {
            repository.firstStartThema(item: ThemaTable(ThemaName: "SeSACThema", Purchase: true))
            repository.firstStartThema(item: ThemaTable(ThemaName: "CottonCandyThema", Purchase: false))
            repository.firstStartThema(item: ThemaTable(ThemaName: "PeachThema", Purchase: false))
            repository.firstStartThema(item: ThemaTable(ThemaName: "NightSkyThema", Purchase: false))
            repository.firstStartThema(item: ThemaTable(ThemaName: "BeachThema", Purchase: false))
        }
        fontTasks = repository.fetchFontTable()
        
        if fontTasks.isEmpty {
            repository.firstStartFont(item: FontTable(FontName: "UhBeeFont", Purchase: true))
            repository.firstStartFont(item: FontTable(FontName: "GangwonFont", Purchase: false))
            repository.firstStartFont(item: FontTable(FontName: "LeeSeoyunFont", Purchase: false))
            repository.firstStartFont(item: FontTable(FontName: "SimKyunghaFont", Purchase: false))
            
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //화면 꺼지지 않게 하는 코드
        UIApplication.shared.isIdleTimerDisabled = true
        todayRealmNotSet()
        userTasks = repository.fetchUser()
        startButtonClicked()
        //        mainview.iconImageView.image = UIImage(named: "seeds")
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //값 전달을 위한 fetch
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        DispatchQueue.main.async {
            self.mainview.insetCoinView.clipsToBounds = true
            self.mainview.insetCoinView.layer.cornerRadius = 10
            
            self.mainview.buttonIncludeView.clipsToBounds = true
            self.mainview.buttonIncludeView.layer.cornerRadius = 12
            
        }
        
        userTasks = repository.fetchUser()
        if repository.todayFilter().isEmpty {
            mainview.famousSayingLabel.text = "오늘 0분 동안 집중했습니다."
            
        } else {
            var totalStudyTime = 0
            if repository.todayTotalStudyTime().isEmpty {
                mainview.famousSayingLabel.text = "오늘 0분 동안 집중했습니다."
            } else {
                for i in 0...repository.todayTotalStudyTime().count - 1 {
                    totalStudyTime += repository.todayTotalStudyTime()[i].SettingTime
                }
                
                let hour = totalStudyTime / 3600
                let minutes = totalStudyTime % 3600 / 60
                
                if hour == 0 {
                    mainview.famousSayingLabel.text = "오늘 \(minutes)분 동안 집중했습니다."
                } else {
                    mainview.famousSayingLabel.text = "오늘 \(hour)시간 \(minutes)분 동안 집중했습니다."
                }
            }
            
        }
        
        
        mainview.totalCoinLabel.text = "\(repository.totalCoin(item: coinTasks))"
    }
    
    
    override func loadView() {
        super.view = mainview
    }
    
    override func configure() {
        
        
        let minutes = self.mainview.settingCount / 60
        let seconds = self.mainview.settingCount % 60
        self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        self.mainview.stopCountLabel.text = "멈출 수 있는 기회는 \(UserDefaults.standard.integer(forKey: "stop"))번!"
        
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = themaChoice().mainColor
        appearence.shadowColor = .clear
        
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        //        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.tintColor = themaChoice().mainColor
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        
        
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
        vc.userTasks = vc.repository.fetchUser()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func bulbButtonClicked() {
        
        hiddenCount += 1
        if hiddenCount == 11 {
            let vc = GetCodeInputViewController()
            transition(vc, transitionStyle: .push)
        } else {
            switch bulbBool {
            case true:
                UIScreen.main.brightness = 0.0
                bulbBool.toggle()
            case false:
                UIScreen.main.brightness = CGFloat(UserDefaults.standard.float(forKey: "bright"))
                bulbBool.toggle()
            }
        }
        

    }
    
    func startButtonClicked() {
        mainview.startButton.addTarget(self, action: #selector(startButtonClickedCountDown), for: .touchUpInside)
        
    }
    
    
    
    @objc func startButtonClickedCountDown() {
        
        if firstStartButtonClicked == true {
            firstStartButtonClicked.toggle()
            self.repository.addItem(item: UserTable(SettingTime: self.mainview.settingCount))
        }
        
        if startButtonBool == true {
            UserDefaults.standard.set(true, forKey: "going")
            startButtonBool.toggle()
            self.mainview.startButton.setTitle("중지", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
                self.mainview.settingCount -= 1
                let minutes = self.mainview.settingCount / 60
                let seconds = self.mainview.settingCount % 60
                
                if self.mainview.settingCount > 0 {
                    
                    self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                    self.mainview.countTimeLabel.text = "\(minutes):\(seconds)"
                    self.progress = Float(self.mainview.settingCount) / Float(UserDefaults.standard.integer(forKey: "engagedTime"))
                    self.mainview.circularProgressBar.setProgressWithAnimation(duration: 0.01, value: 1.0 - self.progress)
                    
                    
                } else {
                    self.firstStartButtonClicked = true
                    self.mainview.startButton.setTitle("완료", for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                    self.finishPopupVCAppear()
                    self.mainview.settingCount = UserDefaults.standard.integer(forKey: "engagedTime")
                    let minutes = self.mainview.settingCount / 60
                    let seconds = self.mainview.settingCount % 60
                    UserDefaults.standard.set(false, forKey: "going")
                    self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                }
            }
        } else {
            if UserDefaults.standard.integer(forKey: "stop") != 0 {
                print("🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏",self.progress)
                
                UserDefaults.standard.set(false, forKey: "going")
                startButtonBool.toggle()
                self.mainview.startButton.setTitle("시작", for: .normal)
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "stop")-1, forKey: "stop")
                print(UserDefaults.standard.integer(forKey: "stop"))
                mainview.stopCountLabel.text = "멈출 수 있는 기회는 \(UserDefaults.standard.integer(forKey: "stop"))번!"
                
                timer?.invalidate()
                timer = nil
            } else {
                self.mainview.makeToast("멈출 수 있는 기회를 다 써버렸어요 😣")
            }
            
        }
        
    }
    
    func finishPopupVCAppear() {
        let vc = FinishPopupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
        
    }
    
    func updateImage() {
        var totalStudyTime = 0
        
        if repository.todayTotalStudyTime().isEmpty {
            mainview.iconImageView.image = ChangedImage(time: 0)
            
        } else {
            
            for i in 0...repository.todayTotalStudyTime().count - 1 {
                totalStudyTime += repository.todayTotalStudyTime()[i].SettingTime
            }
            mainview.iconImageView.image =  ChangedImage(time: totalStudyTime)
        }
    }
    
    func ChangedImage(time: Int) -> UIImage? {
        
        
        switch time {
        case 0:
            return UIImage(named: "seeds")
        case 1...7199:
            return UIImage(named: "sprout")
        case 7200...14399:
            return UIImage(named: "blossom")
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
            repository.addItem(item: UserTable(SettingTime: self.mainview.settingCount))
            userTasks = repository.fetchUser()
        }
    }
    
    
    
    // 총 코인을 일치시켜주는 함수
    
}

extension MainViewController: settingTimeDelegate {
    func sendSettingTime(_ time: Int) {
        getSettingTime.append(time)
        mainview.settingCount = getSettingTime.startIndex
    }
}
