//
//  BaseViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/10.
//

import Foundation

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setConstants()
    }
    
    
    func configure() {}
    
    func setConstants() {}
    
    
    func showAlertMessage(title: String, button: String = "확인") { //매개변수 기본값
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
}




