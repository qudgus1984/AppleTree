//
//  CodeInputViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit
import RealmSwift
import Toast

class GetCodeInputViewController: BaseViewController {
 
    let mainview = GetCodeInputView()
    let repository = ATRepository()
    
    var coinTasks: Results<CoinTable>! {
        didSet {
            coinTasks = repository.fetchCoinTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishButtonClicked()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.mainview.codeInputView.clipsToBounds = true
            self.mainview.codeInputView.layer.cornerRadius = 10
            
            self.mainview.finishButton.clipsToBounds = true
            self.mainview.finishButton.layer.cornerRadius = 12
            
        }
    }
    
    override func loadView() {
        super.view = mainview
    }
    
    func finishButtonClicked() {
        mainview.finishButton.addTarget(self, action: #selector(finishButtonClickedCountDown), for: .touchUpInside)
        
    }
    
    
    
    @objc func finishButtonClickedCountDown() {
        
        coinTasks = repository.fetchCoinTable()
        
        if mainview.codeInputTextField.text == "SeSAC" {
            if UserDefaults.standard.string(forKey: "SeSAC") == "SeSAC" {
                self.mainview.makeToast("이미 사용하신 코드입니다.")
            } else {
                repository.addCoin(item: CoinTable(GetCoin: 3000, SpendCoin: 0, Status: 1000))
                UserDefaults.standard.set("SeSAC", forKey: "SeSAC")
                self.mainview.makeToast("SeSAC 화이팅🌱")
            }
        } else if mainview.codeInputTextField.text == "growtime" {
            if UserDefaults.standard.string(forKey: "growtime") == "growtime" {
                self.mainview.makeToast("이미 사용하신 코드입니다.")
            } else {
                repository.addCoin(item: CoinTable(GetCoin: 1000, SpendCoin: 0, Status: 1001))
                UserDefaults.standard.set("growtime", forKey: "growtime")
                self.mainview.makeToast("1000코인이 지급되었습니다.")
            }

        } else if mainview.codeInputTextField.text == "minju" {
            if UserDefaults.standard.string(forKey: "minju") == "minju" {
                self.mainview.makeToast("민주야 사랑해♥️")
            } else {
                repository.addCoin(item: CoinTable(GetCoin: 10000, SpendCoin: 0, Status: 1002))
                UserDefaults.standard.set("minju", forKey: "minju")
                self.mainview.makeToast("민주야 사랑해♥️")
            }
        } else if mainview.codeInputTextField.text == "concrete" {
            if UserDefaults.standard.string(forKey: "concrete") == "concrete" {
                self.mainview.makeToast("이미 사용하신 코드입니다.")
            } else {
                repository.addCoin(item: CoinTable(GetCoin: 5000, SpendCoin: 0, Status: 1003))
                UserDefaults.standard.set("concrete", forKey: "concrete")
                self.mainview.makeToast("콘크리트는 영원하다 🧱")
            }
        } else {
            self.mainview.makeToast("등록되지 않은 코드입니다.")
        }
    }
}
