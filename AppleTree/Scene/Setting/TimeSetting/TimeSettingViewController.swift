//
//  TimeSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit

protocol settingTimeDelegate {
    func sendSettingTime(_ time: Int)
}

class TimeSettingViewController: BaseViewController {

    let mainview = TimeSettingView()
    
    var delegate: settingTimeDelegate?
    
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
        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
    }


}

extension TimeSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TimeSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        
        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "이정도는 가뿐해! 15분! + 1코인"
        case 1:
            cell.explainLabel.text = "짧고 굵게!! 30분 + 3코인"
        case 2:
            cell.explainLabel.text = "데일리한 1시간! + 8코인"
        case 3:
            cell.explainLabel.text = "집중 하기 좋은 2시간! + 20코인"
        case 4:
            cell.explainLabel.text = "4시간...도전해볼까요?! + 50코인"
        case 5:
            cell.explainLabel.text = "8시간!! 켠김에 왕까지?! + 120코인"
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
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(15*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(30*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }

        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(60*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }

        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(120*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(240*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 5:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(480*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        default:
            print("error발생")
        }
    }
    
}
