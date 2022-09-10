//
//  MainViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import UIKit

class MainViewController: BaseViewController {

    let mainview = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.view = mainview
    }
    
    override func configure() {
        
        //MARK: Nav 색상 변경
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .customDarkGreen
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        
        
        //MARK: Nav 바 버튼 관련
        let calenderButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(calenderButtonClicked))
        calenderButton.tintColor = .white
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "lightbulb"), style: .plain, target: self, action: #selector(settingButtonClicked))
        settingButton.tintColor = .white
        let bulbButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(bulbButtonClicked))
        bulbButton.tintColor = .white
        navigationItem.leftBarButtonItems = [calenderButton]
        navigationItem.rightBarButtonItems = [bulbButton, settingButton]
    }
    
    @objc func calenderButtonClicked() {
        
    }
    
    @objc func settingButtonClicked() {
        
    }
    
    @objc func bulbButtonClicked() {
        
    }
    


    
}
