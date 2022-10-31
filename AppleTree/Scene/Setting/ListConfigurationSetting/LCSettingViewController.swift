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

