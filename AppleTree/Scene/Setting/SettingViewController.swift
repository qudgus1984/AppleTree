//
//  SettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit

class SettingViewController: BaseViewController {

    let mainview = SettingView()
    
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
        appearence.backgroundColor = .huntLightGreen
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .huntLightGreen
        
        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "공지사항"
        case 1:
            cell.explainLabel.text = "집중 시간 설정"
        case 2:
            cell.explainLabel.text = "집중 시간 통계"
        case 3:
            cell.explainLabel.text = "데이터 저장 및 복원"
        default:
            print("error발생")
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showAlertMessage(title: "업데이트 예정입니다.")
        case 1:
            let vc = TimeSettingViewController()
            transition(vc, transitionStyle: .push)
        case 2:
            showAlertMessage(title: "업데이트 예정입니다.")
        case 3:
            showAlertMessage(title: "업데이트 예정입니다.")
        default:
            print("error발생")
            
        }

    }
    
}
