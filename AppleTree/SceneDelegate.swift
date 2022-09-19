//
//  SceneDelegate.swift
//  AppleTree
//
//  Created by 이병현 on 2022/08/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {


        
        if UserDefaults.standard.integer(forKey: "engagedTime") == 0 {
            UserDefaults.standard.set(0, forKey: "thema")
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let rootViewController = TimeSettingViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let rootViewController = MainViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            UserDefaults.standard.set(false, forKey: "going")
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        if UserDefaults.standard.integer(forKey: "stop") == 0 {
            UserDefaults.standard.set(3, forKey: "stop")
        }

            window?.makeKeyAndVisible()
            
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")

    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        //앱 지우기 전 설정 창 화면
        print("sceneWillResignActive")


    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground")

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        //백그라운드 간 상태
        
        if UserDefaults.standard.bool(forKey: "going") {
            print("sceneDidEnterBackground")
            
            MainViewController().timer?.invalidate()
            MainViewController().timer = nil
            UserDefaults.standard.set(false, forKey: "going")
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let rootViewController = ResetPopupViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()

        }

    }


}

