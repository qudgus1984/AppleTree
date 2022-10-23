//
//  LCSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/22.
//

import UIKit



final class LCSettingViewController: BaseViewController {
    
    
    var list: [String] = ["집중 시간 설정", "집중 시간 통계", "테마 구매 / 설정", "폰트 구매 / 설정"]
    
    
    private let mainview = LCSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.colletcionView.delegate = self
        mainview.colletcionView.dataSource = self

        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = themaChoice().lightColor
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        mainview.colletcionView.collectionViewLayout = layout
        


    }
    
    override func loadView() {
        super.view = mainview
    }


    override func configure() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = themaChoice().lightColor
        appearence.shadowColor = .clear

        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}

extension LCSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
        }
        
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        
        return cell


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
}

//
//extension LCSettingViewController {
//
//}
//
//extension SimpleCollectionViewController {
//
//    private func backgroundSetting() -> UIBackgroundConfiguration {
//        var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
//        backgroundConfig.backgroundColor = .lightGray
//        backgroundConfig.cornerRadius = 10
//        backgroundConfig.strokeWidth = 2
//        backgroundConfig.strokeColor = .systemPink
//        return backgroundConfig
//    }
//}
//extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return SettingEnum.allCases.count
//
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else { return UITableViewCell() }
//        cell.backgroundColor = themaChoice().lightColor
//        cell.selectionStyle = .none
//        cell.explainLabel.text = SettingEnum.allCases[indexPath.row].rawValue
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            let vc = TimeSettingViewController()
//            transition(vc, transitionStyle: .push)
//        case 1:
//            let vc = ChartViewController()
//            transition(vc, transitionStyle: .push)
//        case 2:
//            let vc = ThemaSettingViewController()
//            transition(vc, transitionStyle: .push)
//        case 3:
//            let vc = FontSettingViewController()
//            transition(vc, transitionStyle: .push)
//        default:
//            print("error발생")
//
//        }
//
//    }
//
//}
//
