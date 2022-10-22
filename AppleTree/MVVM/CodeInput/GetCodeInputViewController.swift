//
//  CodeInputViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit
import RealmSwift
import Toast

final class GetCodeInputViewController: BaseViewController {
    
    private let mainview = GetCodeInputView()
    let repository = ATRepository()
    
    var coinTasks: Results<CoinTable>! {
        didSet {
            coinTasks = repository.fetchCoinTable()
        }
    }
    
    var viewModel = GetCodeInputViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishButtonClicked()
        changeTextField()
        
        viewModel.isValid.bind { bool in
            self.mainview.finishButton.backgroundColor = bool ? themaChoice().mainColor : .systemGray
        }
        
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
    
    func changeTextField() {
        mainview.codeInputTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc func textChanged() {
        viewModel.couponCode.value = mainview.codeInputTextField.text ?? nil
        viewModel.checkValidation()
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
        self.view.endEditing(true)
    }
}
