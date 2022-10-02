//
//  Transition+Extension.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/08.
//

import UIKit

//MARK: 화면 전환 설정
extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 Present
        case presentNavigation //네비게이션 임베드 Present
        case presentFullNavigation //네비게이션 풀스크린
        case push
        case rootViewControllerChange
    }
    

    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .rootViewControllerChange:
            changeRootVC()
        }
    }
    
    func changeRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = MainViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    
    func changeTimeSettingRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = TimeSettingViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    

}
