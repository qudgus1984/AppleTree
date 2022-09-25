//
//  FinishPopupViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/12.
//

import UIKit
import RealmSwift

class FinishPopupViewController: BaseViewController {
    
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
    }
    
    //MARK: 확인 버튼 클릭 시
    override func configure() {
        mainview.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        
        self.repository.updateState(item: repository.todayFilter().last!, Sucess: true)
        self.repository.addCoin(item: CoinTable(GetCoin: coinCalculator(), SpendCoin: 0, Category: "완료"))
        UserDefaults.standard.set(3, forKey: "stop")
        dismiss(animated: true)
    }
    
    func ChangedImage(time: Int) -> UIImage? {

        
        switch time {
        case 0...1200:
            return UIImage(named: "seeds")
        case 1201...2400:
            return UIImage(named: "sprout")
        case 2401...4801:
            return UIImage(named: "apple")
        case 4801...:
            return UIImage(named: "apple-tree")
        default:
            return nil
        }
    }
    
    func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 2000
        case 60 * 30 :
            return 3
        case 60 * 60 :
            return 8
        case 60 * 120:
            return 20
        case 60 * 240:
            return 50
        case 60 * 480:
            return 120
        default:
            return 0
        }
    }
    
}
