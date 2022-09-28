//
//  FontSettingViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/28.
//

import UIKit
import RealmSwift

class FontSettingViewController: BaseViewController {

    let mainview = FontSettingView()
    let repository = ATRepository()
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
        }
    }
    
    var fontTasks: Results<FontTable>! {
        didSet {
            fontTasks = repository.fetchFontTable()
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


}

extension FontSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FontSettingTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        fontTasks = repository.fetchFontTable()
        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "UhBee 폰트 🌱"
        case 1:
            cell.explainLabel.font = UIFont(name: "GangwonEduAll-OTFBold", size: 24)
            cell.explainLabel.text = "Gangwon 폰트 💜"
            

            
            if fontTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")
            }
            

        case 2:
            cell.explainLabel.font = UIFont(name: "LeeSeoyun", size: 24)
            cell.explainLabel.text = "LeeSeoyun 폰트 🍑"

            if fontTasks[indexPath.row].Purchase == false {
                cell.containView.backgroundColor = .systemGray
                cell.lockImageView.image = UIImage(systemName: "lock.fill")


            }
            

        case 3:
            cell.explainLabel.font = UIFont(name: "SimKyungha", size: 24)
            cell.explainLabel.text = "Simkyungha 폰트 🌌"

            if fontTasks[indexPath.row].Purchase == false {
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
                UserDefaults.standard.set(0, forKey: "font")
                
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
                
            } else {
                //만약 테마를 구입 안했다면
                if fontTasks[indexPath.row].Purchase == false {
                    
                    //만약 코인이 2000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 300 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 300코인이 필요해요!")
                    } else {
                        fontBuyAlert(fontNum: indexPath.row, message: "300코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(1, forKey: "font")

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if fontTasks[indexPath.row].Purchase == false {
                    
                    //만약 코인이 2000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 300 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 300코인이 필요해요!")
                    } else {
                        fontBuyAlert(fontNum: indexPath.row, message: "300코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(2, forKey: "font")

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if fontTasks[indexPath.row].Purchase == false {
                    //만약 코인이 2000개 이하라면
                    if repository.totalCoin(item: coinTasks) < 300 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 300코인이 필요해요!")
                    } else {
                        fontBuyAlert(fontNum: indexPath.row, message: "300코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(3, forKey: "font")

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }


        default:
            print("error발생")
        }
    }

    
    func fontBuyAlert(fontNum: Int, message: String) {
        let alert = UIAlertController(title: "테마를 구입하시겠습니까?", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ [self](_) in
            
            //테마 구입 했을 때 추가
            self.fontTasks = self.repository.fetchFontTable()
            
            // 테마 구입 시 true로 변경
            self.repository.changeTFontBool(item: fontTasks[fontNum], fontNum: fontNum)
            
            // 테마 구입 시 true 변경 값 및 코인 개수 - 2000 업데이트
            self.repository.addCoin(item: CoinTable(GetCoin: 0, SpendCoin: -300, Status: 500 + fontNum))
            UserDefaults.standard.set(fontNum, forKey: "font")

            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .presentFullNavigation)
            

            
        }
        alert.addAction(okAction)

        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }
}
