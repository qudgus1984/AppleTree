//
//  SettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit

final class SettingViewController: BaseViewController {

    private let mainview = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.tableView.dataSource = self
        mainview.tableView.delegate = self
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

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingEnum.allCases.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        cell.explainLabel.text = SettingEnum.allCases[indexPath.row].rawValue
//        switch indexPath.row {
//
//        case 0:
//            cell.explainLabel.text = SettingEnum.zero.rawValue
//        case 1:
//            cell.explainLabel.text = SettingEnum.first.rawValue
//        case 2:
//            cell.explainLabel.text = SettingEnum.second.rawValue
//        case 3:
//            cell.explainLabel.text = SettingEnum.third.rawValue
//
//        default:
//            print("error발생")
//
//        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = TimeSettingViewController()
            transition(vc, transitionStyle: .push)
        case 1:
            let vc = ChartViewController()
            transition(vc, transitionStyle: .push)
        case 2:
            let vc = ThemaSettingViewController()
            transition(vc, transitionStyle: .push)
        case 3:
            let vc = FontSettingViewController()
            transition(vc, transitionStyle: .push)
        default:
            print("error발생")
            
        }

    }
    
}
