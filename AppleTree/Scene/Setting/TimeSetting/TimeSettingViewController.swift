//
//  TimeSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/15.
//

import UIKit
import RealmSwift

protocol settingTimeDelegate {
    func sendSettingTime(_ time: Int)
}

final class TimeSettingViewController: BaseViewController {
    
    private let mainview = TimeSettingView()
    
    private var delegate: settingTimeDelegate?
    
    private let repository = ATRepository()
    private var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.tableView.dataSource = self
        mainview.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userTasks = repository.fetchUser()
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
    }
    
    
}

extension TimeSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TimeSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        cell.explainLabel.text = TimeSettingEnum.allCases[indexPath.row].rawValue

        
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
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(30*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
            
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(60*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
            
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(120*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(240*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
        case 5:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 시간을 재설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(480*60, forKey: "engagedTime")
                print(UserDefaults.standard.integer(forKey: "engagedTime"))
                delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
                changeRootVC()
                
            }
        default:
            print("error발생")
        }
    }
    
}
