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
    
    let mainview = MainView()
    let repository = ATRepository()
    
    var firstStartButtonClicked = true
    
    var bulbBool = true
    

    
    // 값 전달을 위한 fetch
    var tasks: Results<AppleTree>! {
        didSet {
            tasks = repository.fetch()
            updateImage()
        }
    }
        
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        UserDefaults.standard.set(UIScreen.main.brightness, forKey: "bright")
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        //화면 꺼지지 않게 하는 코드
        UIApplication.shared.isIdleTimerDisabled = true
        todayRealmNotSet()
        tasks = repository.fetch()
        switch tasks.count {
        case 1:
            print("코인 0개")
        default:
            coinState()
        }

//        coinAppend()
        tasks = repository.fetch()
        startButtonClicked()
//        mainview.iconImageView.image = UIImage(named: "seeds")
    }
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        //여기서 cornerRadius를 적용시켜주어야 함!@!@!@!
        

        

    }
    
    //값 전달을 위한 fetch
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.mainview.insetCoinView.clipsToBounds = true
            self.mainview.insetCoinView.layer.cornerRadius = 10
        }

        tasks = repository.fetch()
        let hour = repository.todayFilter()[0].ATTime / 3600
        let minutes = repository.todayFilter()[0].ATTime % 3600 / 60
        
        if hour == 0 {
            mainview.famousSayingLabel.text = "오늘 \(minutes)분 동안 집중했습니다."
        } else {
            mainview.famousSayingLabel.text = "오늘 \(hour)시간 \(minutes)분 동안 집중했습니다."
        }
        
        
        mainview.totalCoinLabel.text = "\(repository.todayFilter().last?.ATTotalCoin ?? 0)"
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

//        appearence.backgroundColor = themaChoice().lightColor

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
        vc.tasks = vc.repository.fetch()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func settingButtonClicked() {
        let vc = SettingViewController()
        transition(vc, transitionStyle: .push)
    }
    
    @objc func bulbButtonClicked() {

        switch bulbBool {
        case true:
            UIScreen.main.brightness = 0.0
            bulbBool.toggle()
        case false:
            UIScreen.main.brightness = CGFloat(UserDefaults.standard.float(forKey: "bright"))
            bulbBool.toggle()
        }
    }
    
    func startButtonClicked() {
        mainview.startButton.addTarget(self, action: #selector(startButtonClickedCountDown), for: .touchUpInside)
        
    }

    
    
    @objc func startButtonClickedCountDown() {
        
        if firstStartButtonClicked == true {
            firstStartButtonClicked.toggle()
            self.repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: self.mainview.settingCount, ATState: 2))
            coinAppend()
        }

        if startButtonBool == true {
            UserDefaults.standard.set(true, forKey: "going")
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
                    self.mainview.circularProgressBar.setProgressWithAnimation(duration: 0.0001, value: 1.0 - self.progress)
                    
                    
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
                self.mainview.makeToast("멈출 수 있는 기회를 다써버려찌 머얌 :)")
            }
            
        }
        
    }
    
    func finishPopupVCAppear() {
        let vc = FinishPopupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
        
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
            repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0, ATState: 0))
            
        }
    }
    
    // 총 코인을 일치시켜주는 함수
    func coinAppend() {
        repository.coinAppend(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
    
    func coinState() {
        repository.coinState(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
}

extension MainViewController: settingTimeDelegate {
    func sendSettingTime(_ time: Int) {
        getSettingTime.append(time)
        mainview.settingCount = getSettingTime.startIndex
    }
    

}
