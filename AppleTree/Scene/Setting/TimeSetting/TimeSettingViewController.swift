//
//  TimeSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit

class TimeSettingViewController: BaseViewController {

    let mainview = TimeSettingView()
    
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

extension TimeSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TimeSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .huntLightGreen
        
        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "15분"
        case 1:
            cell.explainLabel.text = "30분"
        case 2:
            cell.explainLabel.text = "1시간"
        case 3:
            cell.explainLabel.text = "2시간"
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
            showAlertMessage(title: "업데이트 예정입니다.")
        case 2:
            showAlertMessage(title: "업데이트 예정입니다.")
        case 3:
            showAlertMessage(title: "업데이트 예정입니다.")
        default:
            print("error발생")
            
        }
    }
    
}
