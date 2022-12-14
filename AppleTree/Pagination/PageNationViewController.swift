//
//  PagiNationViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit

final class PageNationViewController: UIPageViewController {
    
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()

    //뷰컨트롤러 배열

    lazy var vc1: UIViewController = {
        let vc = FirstViewController()
        vc.view.backgroundColor = .red

        return vc
    }()

    lazy var vc2: UIViewController = {
        let vc = SecondViewController()
        vc.view.backgroundColor = .green

        return vc
    }()

    lazy var vc3: UIViewController = {
        let vc = ThirdViewController()
        vc.view.backgroundColor = .blue

        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewDidLoad()에서 호출
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        UserDefaults.standard.set(UIScreen.main.brightness, forKey: "bright")
        print(UIScreen.main.brightness)
        
        configure()
        setupDelegate()
        

    }
    
    private func configure() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(72)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)

        func setupDelegate() {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

}

extension PageNationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
