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
        appearence.shadowColor = .clear

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
        cell.selectionStyle = .none

        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "SeSAC 테마 🌱"
        case 1:
            cell.explainLabel.text = "몽환적 솜사탕 테마💜"

            if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                cell.containView.backgroundColor = .systemGray
            }
            

        case 2:
            cell.explainLabel.text = "달콤한 복숭아 테마🍑"
            if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                cell.containView.backgroundColor = .systemGray
            }
            

        case 3:
            cell.explainLabel.text = "감성적 밤하늘 테마🌌"
            if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                cell.containView.backgroundColor = .systemGray
            }
        case 4:
            cell.explainLabel.text = "시원한 바닷가 테마🏖"
            if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                cell.containView.backgroundColor = .systemGray
            }
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
                themaState()
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                    //만약 코인이 2000개 이하라면
                    if tasks[tasks.count - 1].ATTotalCoin < 2000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 2000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "2000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(1, forKey: "thema")
                    addRecord()
                    coinState()
                    themaState()

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                    //만약 코인이 2000개 이하라면
                    if tasks[tasks.count - 1].ATTotalCoin < 2000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 2000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "2000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(2, forKey: "thema")
                    addRecord()
                    coinState()
                    themaState()

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                    //만약 코인이 2000개 이하라면
                    if tasks[tasks.count - 1].ATTotalCoin < 2000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 2000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "2000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(3, forKey: "thema")
                    addRecord()
                    coinState()
                    themaState()

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                    //만약 코인이 2000개 이하라면
                    if tasks[tasks.count - 1].ATTotalCoin < 2000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 2000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "2000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(4, forKey: "thema")
                    addRecord()
                    coinState()
                    themaState()

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }


        default:
            print("error발생")
        }
    }
    
    func addRecord() {
        self.repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0, ATState: 4))
    }
    
    func coinState() {
        repository.coinState(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
    
    func themaState() {
        repository.themaState(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
    
    func themaBuyAlert(ThemaNum: Int, message: String) {
        let alert = UIAlertController(title: "테마를 구입하시겠습니까?", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ [self](_) in
            
            //테마 구입 했을 때 추가
            self.repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0, ATState: 6))
            self.tasks = self.repository.fetch()
            
            // 이전과 코인 개수 같도록 만들어주고
            self.repository.coinState(item: self.tasks[self.tasks.count - 1], beforeItem: self.tasks[self.tasks.count - 2])
            
            // 이전과 테마 같도록 만들어주고
            self.repository.themaState(item: self.tasks[self.tasks.count - 1], beforeItem: self.tasks[self.tasks.count - 2])

            // 테마 구입 시 true로 변경
            self.repository.changeThemaBool(item: self.tasks[self.tasks.count - 1], ThemaNum: ThemaNum)
            
            // 테마 구입 시 true 변경 값 및 코인 개수 - 2000 업데이트
            self.repository.themaBuy(item: self.tasks[self.tasks.count - 1], Themalist: self.tasks[self.tasks.count - 1].ATThema, Subtract: self.tasks[self.tasks.count - 1].ATTotalCoin - 2000)
            
            UserDefaults.standard.set(ThemaNum, forKey: "thema")

            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .presentFullNavigation)
            

            
        }
        alert.addAction(okAction)

        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }
}
