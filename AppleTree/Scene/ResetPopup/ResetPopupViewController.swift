//
//  ResetPopupViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/18.
//

import UIKit
import RealmSwift

class ResetPopupViewController: BaseViewController {
    
    
    var getSettingTime: [Int] = []
    
    var startButtonBool: Bool = true
    var timer: Timer?
    var progress: Float = 0.0
    
    let mainview = ResetPopupView()
    let repository = ATRepository()
    
    // 값 전달을 위한 fetch
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
            updateImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayRealmNotSet()
        
        
        resetButtonClicked()
        print(progress)
        
        mainview.iconImageView.image = UIImage(named: "seeds")
    }
    
    //값 전달을 위한 fetch
    override func viewWillAppear(_ animated: Bool) {
        userTasks = repository.fetchUser()
    }
    
    
    override func loadView() {
        super.view = mainview
    }
    
    override func configure() {
        
        self.mainview.countTimeLabel.text = "죽었당 식물이 으아앙"
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemGray
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
    }
    
    func resetButtonClicked() {
        
        mainview.startButton.addTarget(self, action: #selector(resetButtonClickedCountDown), for: .touchUpInside)
        
        
    }
    
    @objc func resetButtonClickedCountDown() {
        UserDefaults.standard.set(3, forKey: "stop")
        let vc = MainViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    func finishPopupVCAppear() {
        let vc = FinishPopupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
        
    }
    
    func updateImage() {
        var totalStudyTime = 0
        for i in 0...repository.todayTotalStudyTime().count - 1 {
            totalStudyTime += repository.todayTotalStudyTime()[i].SettingTime
        }
        mainview.iconImageView.image =  ChangedImage(time: totalStudyTime)
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
            repository.addItem(item: UserTable(SettingTime: self.mainview.settingCount))
            userTasks = repository.fetchUser()
        }
    }
    
}

