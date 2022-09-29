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
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayRealmNotSet()
        
        
        resetButtonClicked()
        print(progress)
        
        mainview.iconImageView.image = UIImage(named: "appletreeDie")
    }
    
    //값 전달을 위한 fetch
    override func viewWillAppear(_ animated: Bool) {
        userTasks = repository.fetchUser()
        DispatchQueue.main.async {
            self.mainview.iconImageView.clipsToBounds = true
            self.mainview.iconImageView.layer.cornerRadius = self.mainview.iconImageView.frame.width / 2
            
            self.mainview.buttonInsetView.clipsToBounds = true
            self.mainview.buttonInsetView.layer.cornerRadius = 10
            
        }
    }
    
    
    override func loadView() {
        super.view = mainview
    }
    
    override func configure() {
        
        self.mainview.countTimeLabel.text = "죽었당 사과가 으아앙"
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemGray
        appearence.shadowColor = .clear

        
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
    

    
    
    func todayRealmNotSet() {
        
        if repository.todayFilter().isEmpty {
            repository.addItem(item: UserTable(SettingTime: self.mainview.settingCount))
            userTasks = repository.fetchUser()
        }
    }
    
}

