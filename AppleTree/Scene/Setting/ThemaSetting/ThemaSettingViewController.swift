//
//  ThemaSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/19.
//

import UIKit
import RealmSwift

class ThemaSettingViewController: BaseViewController {

    let mainview = ThemaSettingView()
    let repository = ATRepository()
    var tasks: Results<AppleTree>! {
        didSet {
            tasks = repository.fetch()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainview.tableView.dataSource = self
        mainview.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = repository.fetch()
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

extension ThemaSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TimeSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        
        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "SeSAC 테마 🌱"
        case 1:
            cell.explainLabel.text = "몽환적 솜사탕 테마💜"
        case 2:
            cell.explainLabel.text = "달콤한 복숭아 테마🍑"
        case 3:
            cell.explainLabel.text = "감성적 밤하늘 테마🌌"
        case 4:
            cell.explainLabel.text = "시원한 바닷가 테마🏖"

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
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(0, forKey: "thema")
                addRecord()
                coinState()
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(1, forKey: "thema")
                addRecord()
                coinState()

                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(2, forKey: "thema")
                addRecord()
                coinState()

                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(3, forKey: "thema")
                addRecord()
                coinState()

                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(4, forKey: "thema")
                addRecord()
                coinState()

                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }


        default:
            print("error발생")
        }
    }
    
    func addRecord() {
        self.repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0, ATSucess: 4))
    }
    
    func coinState() {
        repository.coinState(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
}
