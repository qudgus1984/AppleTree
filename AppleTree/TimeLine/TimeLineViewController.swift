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
        cell.backgroundColor = themaChoice().lightColor
        cell.selectionStyle = .none
        cell.explainLabel.text = selectDay(day: coinTasks[indexPath.row].now)
        if coinTasks[indexPath.row].GetCoin > 0 {
            cell.containExplainLabel.text = "\(coinTasks[indexPath.row].GetCoin)의 코인을 얻었습니다."
        } else {
            cell.containExplainLabel.text = "\(coinTasks[indexPath.row].SpendCoin)의 코인을 사용하였습니다."

        }
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

    
}
