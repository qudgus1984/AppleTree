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
        //만약 그 날에 culm이 없다면
//        if AppleTree.ATDate.contains(DateFormatterHelper.Formatter.dateStr){
//
//        } else {
//
//        }
        print(#function)
        
        let result = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )

    //        DateFormatterHelper.Formatter.dateStr
            
        print("==================\(result)")
            
        if result.isEmpty {
            repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: MainView().settingCount))
            print("==========\(AppleTree.self)==============")
        } else {
            repository.updateItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'").first!.ATTime), appendTime: MainView().settingCount)
            print("================\(AppleTree.self)")
            print()

        }
        
            //컬럼이 있다면 업데이트
        dismiss(animated: true)
    }

}
