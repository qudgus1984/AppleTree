//
//  FinishPopupViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import RealmSwift
import FirebaseAnalytics

final class FinishPopupViewController: BaseViewController {
    
    let repository = ATRepository()
    let mainview = FinishPopupView()
    
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
        }
    }
    
    var coinTasks: Results<CoinTable>! {
        didSet {
            coinTasks = repository.fetchCoinTable()
        }
    }
        
    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userTasks = repository.fetchUser()
        coinTasks = repository.fetchCoinTable()
        
        Analytics.logEvent("success", parameters: [
            "name": "성공",
        ])
    }
    
    //MARK: 확인 버튼 클릭 시
    override func configure() {
        mainview.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        userTasks = repository.fetchUser()
        coinTasks = repository.fetchCoinTable()
        self.repository.updateState(item: repository.todayFilter().last!, Sucess: true)
        self.repository.addCoin(item: CoinTable(GetCoin: coinCalculator(), SpendCoin: 0, Status: 101))
        UserDefaults.standard.set(3, forKey: "stop")
        userTasks = repository.fetchUser()
        CalendarView().calendarView.reloadData()
        dismiss(animated: true)
    }
    
    
    func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 1
        case 60 * 30 :
            return 3
        case 60 * 60 :
            return 10
        case 60 * 120:
            return 30
        case 60 * 240:
            return 80
        case 60 * 480:
            return 200
        default:
            return 0
        }
    }
    
}
