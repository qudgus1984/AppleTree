//
//  FirstViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit

class FirstViewController: UIViewController {
    
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
        mainview.explainLabel.text = "정해진 시간을 완료하고, 나무를 성장시켜보세요!"
        mainview.imageView.image = UIImage(named: "apple-tree")
        
    }
    

}
