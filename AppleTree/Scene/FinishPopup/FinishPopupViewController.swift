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
    override func loadView() {
        super.view = mainview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    //MARK: 확인 버튼 클릭 시
    override func configure() {
        mainview.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    @objc func okButtonClicked() {
                
        let result = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
            
        print("==================\(result)")
            
        if result.isEmpty {
            repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: MainView().settingCount))
            print("==========\(AppleTree.self)==============")
        } else {
            self.repository.updateItem(item: result[0], appendTime: MainView().settingCount)
            print("================\(AppleTree.self)")

        }
        
        dismiss(animated: true)
    }
    
    func ChangedImage(time: Int) -> UIImage? {

//        let seedsImg = UIImage(named: "seeds")!
//        let sproutImg = UIImage(named: "sprout")!
//        let appleImg = UIImage(named: "apple")!
//        let appleTreeImg = UIImage(named: "apple-tree")!
        
        switch time {
        case 0...200:
            return UIImage(named: "seeds")
        case 201...410:
            return UIImage(named: "sprout")
        case 411...511:
            return UIImage(named: "apple")
        case 512...6400:
            return UIImage(named: "apple-tree")
        default:
            return nil
        }
    }

}
