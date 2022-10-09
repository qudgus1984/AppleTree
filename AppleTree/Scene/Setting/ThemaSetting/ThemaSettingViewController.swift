//
//  ThemaSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/19.
//

import UIKit
import RealmSwift

final class ThemaSettingViewController: BaseViewController {

    private let mainview = ThemaSettingView()
    private let repository = ATRepository()
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
        }
    }
    
    var themaTasks: Results<ThemaTable>! {
        didSet {
            themaTasks = repository.fetchThemaTable()
        }
    }
    
    var coinTasks: Results<CoinTable>! {
        didSet {
            coinTasks = repository.fetchCoinTable()
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

    func themaBuyAlert(ThemaNum: Int, message: String) {
        let alert = UIAlertController(title: "테마를 구입하시겠습니까?", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ [self](_) in
            
            //테마 구입 했을 때 추가
            self.themaTasks = self.repository.fetchThemaTable()
            
            // 테마 구입 시 true로 변경
            self.repository.changeThemaBool(item: themaTasks[ThemaNum], ThemaNum: ThemaNum)
            
            // 테마 구입 시 true 변경 값 및 코인 개수 - 1000 업데이트
            self.repository.addCoin(item: CoinTable(GetCoin: 0, SpendCoin: -1000, Status: 400 + ThemaNum))
            UserDefaults.standard.set(ThemaNum, forKey: "thema")

            changeRootVC()
        }
        alert.addAction(okAction)

        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }

}

extension ThemaSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ThemaSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        themaTasks = repository.fetchThemaTable()

        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "SeSAC 테마 🌱"
        case 1:
            cell.explainLabel.text = "몽환적 솜사탕 테마💜"

            if themaTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")

            }
            

        case 2:
            cell.explainLabel.text = "달콤한 복숭아 테마🍑"
            if themaTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")

            }
            

        case 3:
            cell.explainLabel.text = "감성적 밤하늘 테마🌌"
            if themaTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")

            }
        case 4:
            cell.explainLabel.text = "시원한 바닷가 테마🏖"
            if themaTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")

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
        coinTasks = repository.fetchCoinTable()
        switch indexPath.row {
        case 0:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(0, forKey: "thema")

                changeRootVC()

            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if themaTasks[indexPath.row].Purchase == false {
                    //만약 코인이 1000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 1000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 1000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "1000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(1, forKey: "thema")
                    changeRootVC()

                }
            }
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if themaTasks[indexPath.row].Purchase == false {
                    //만약 코인이 1000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 1000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 1000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "1000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(2, forKey: "thema")

                    changeRootVC()

                }
            }
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if themaTasks[indexPath.row].Purchase == false {
                    //만약 코인이 1000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 1000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 1000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "1000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(3, forKey: "thema")

                    changeRootVC()

                }
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if themaTasks[indexPath.row].Purchase == false {
                    //만약 코인이 1000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 1000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 1000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "1000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(4, forKey: "thema")

                    changeRootVC()

                }
            }


        default:
            print("error발생")
        }
    }

}
