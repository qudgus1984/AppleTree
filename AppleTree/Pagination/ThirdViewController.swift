//
//  ThirdViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit

class ThirdViewController: UIViewController {

    let mainview = PaginationFinalView()

    override func loadView() {
        super.view = mainview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.mainview.imageView.clipsToBounds = true
            self.mainview.imageView.layer.cornerRadius = self.mainview.imageView.frame.width / 2
            
            self.mainview.finishButton.clipsToBounds = true
            self.mainview.finishButton.layer.cornerRadius = 12
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        finishButtonClicked()
        mainview.explainLabel.text = "보유한 코인으로 테마나 폰트를 구입할 수 있어요!"
        mainview.imageView.image = UIImage(named: "dollar")
    }
    func finishButtonClicked() {
        mainview.finishButton.addTarget(self, action: #selector(finishButtonClickedCountDown), for: .touchUpInside)
        
    }
    
    
    
    @objc func finishButtonClickedCountDown() {
        UserDefaults.standard.set(true, forKey: "firstStart")
        changeTimeSettingRootVC()
    }
}
