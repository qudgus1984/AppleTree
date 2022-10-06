//
//  TimeLineViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/05.
//

import UIKit
import RealmSwift

class TimeLineViewController: BaseViewController {

    let mainview = TimeLineView()
    let repository = ATRepository()
    let dateFormatDay = DateFormatter()

    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
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

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinTasks = repository.fetchCoinTable()
        return coinTasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TimeLineTableViewCell else { return UITableViewCell() }
        userTasks = repository.fetchUser()
        coinTasks = repository.fetchCoinTable()
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        cell.explainLabel.text = selectDay(day: coinTasks[coinTasks.count - indexPath.row - 1].now)
        cell.statusExplainLabel.text = statusLogicFunc(status: coinTasks[coinTasks.count - indexPath.row - 1].Status)
        if coinTasks[coinTasks.count - indexPath.row - 1].GetCoin > 0 {
            cell.containExplainLabel.text = "\(coinTasks[coinTasks.count - indexPath.row - 1].GetCoin)의 코인을 얻었습니다."

        } else {
            cell.containExplainLabel.text = "\(coinTasks[coinTasks.count - indexPath.row - 1].SpendCoin)의 코인을 사용하였습니다."

        }
        let selectDay = repository.dayTotalTimeFilter(date: coinTasks[coinTasks.count - indexPath.row - 1].now)
        cell.iconImageView.image = ChangedImage(time: selectDay)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    

    func formatDate() {
        
        dateFormatDay.dateFormat = "yy-MM-dd hh:mm"
    }
    
    func selectDay(day: Date) -> String {
        formatDate()
        return dateFormatDay.string(from: day)
    }

    func ChangedImage(time: Int) -> UIImage? {
        
        
        switch time {
        case 0:
            return UIImage(named: "seeds")
        case 1...7199:
            return UIImage(named: "sprout")
        case 7200...14399:
            return UIImage(named: "blossom")
        case 14400...21599:
            return UIImage(named: "apple")
        case 21600...:
            return UIImage(named: "apple-tree")
        default:
            return nil
        }
        
    }
    
    func statusLogicFunc(status: Int) -> String {
        switch status {
        case 100:
            return "처음 출석하셨습니다."
        case 101:
            return "정해진 시간을 완료하셨습니다."
        case 401:
            return "몽환적 솜사탕 테마💜를 구입하셨습니다."
        case 402:
            return "달콤한 복숭아 테마🍑를 구입하셨습니다."
        case 403:
            return "감성적 밤하늘 테마🌌를 구입하셨습니다."
        case 404:
            return "시원한 바닷가 테마🏖를 구입하셨습니다."
        case 501:
            return "Gangwon 폰트🦋를 구입하셨습니다."
        case 502:
            return "LeeSeoyun 폰트✨를 구입하셨습니다."
        case 503:
            return "Simkyungha 폰트🌃를 구입하셨습니다."
        case 1000:
            return "SeSAC 화이팅🌱"
        case 1001:
            return "쿠폰 코드를 입력하셨습니다."
        case 1002:
            return "♥️"
        case 1003:
            return "콘크리트여 영원하라🧱"
        default:
            return "입력되지 않은 상태코드입니다."
            
        }
    }
    
}
