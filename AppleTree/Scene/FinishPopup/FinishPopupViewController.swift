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
    
    var tasks: Results<AppleTree>! {
        didSet {
            tasks = repository.fetch()
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
        tasks = repository.fetch()
    }
    
    //MARK: 확인 버튼 클릭 시
    override func configure() {
        mainview.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
        
        self.repository.updateItem(item: repository.todayFilter()[0], appendTime: MainView().settingCount)
        print(repository.todayFilter().last!)
        self.repository.updateState(item: repository.todayFilter().last!, State: 1)
        UserDefaults.standard.set(3, forKey: "stop")
        print("================\(AppleTree.self)")
        
        

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
    
    // 총 코인을 더해주는 함수
    func coinAppend() {
        repository.coinAppend(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }

    
}
