//
//  SecondViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit

final class SecondViewController: UIViewController {

    let mainview = PaginationView()

    override func loadView() {
        super.view = mainview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.mainview.imageView.clipsToBounds = true
            self.mainview.imageView.layer.cornerRadius = self.mainview.imageView.frame.width / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.explainLabel.text = "설정한 시간을 완료하지 않고 앱을 나가면 나무가 시들어요."
        mainview.imageView.image = UIImage(named: "appletreeDie")
    }

}
