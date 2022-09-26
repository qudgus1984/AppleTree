//
//  ChartViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/26.
//

import UIKit
import Charts
import RealmSwift

class ChartViewController: BaseViewController {
    let mainview = ChartView()
    
    var months: [String]!
    var unitsSold: [Double]!
    var days: [String]!
    var weeks: [String]!
    
    var repository = ATRepository()
    
    var userTasks: Results<UserTable>! {
        didSet {
            userTasks = repository.fetchUser()
        }
    }
    
    

    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        segmentAppear()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.segmentAppear()
        }
    }
    
    
    override func configure() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = themaChoice().lightColor
        appearence.shadowColor = .clear

        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
    }
    
    func segmentAppear() {
        
        mainview.segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        
        // 앱을 켰을 때 control 선택을 지정하는것입니다. 만약 없다면 아무것도 지정되지 않아요
        mainview.segmentedControl.selectedSegmentIndex = 0

        // 선택된 배경색을 변경하는 겁니다.
        mainview.segmentedControl.selectedSegmentTintColor = themaChoice().lightColor

        // 전체 배경색을 바꾸는 겁니다.
        mainview.segmentedControl.backgroundColor = themaChoice().calendarChoiceColor

        // selected와 normal의 글씨 색을 바꾸는겁니다.
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: themaChoice().mainColor]
        mainview.segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mainview.segmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .selected)
        chartsAppearDays()

    }
    
    func chartsAppearMonths() {
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        setBarChartMonths(dataPoints: months, values: unitsSold)
    }
    
    func chartsAppearDays() {
        days = ["6~8", "8~10", "10~12", "12~14", "14~16", "16~18", "18~20", "20~22", "22~24", "24~2", "2~4", "4~6"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        setBarChartDays(dataPoints: days, values: unitsSold)
    }
    
    func chartsAppearWeeks() {
        weeks = ["zzzz", "zzzz", "zzzz", "zzz", "zz", "yesterday", "오늘"]
        
        unitsSold = [5,10,20,10,5,4,7]
        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        setBarChartWeeks(dataPoints: weeks, values: unitsSold)
    }
    // control를 했을 때 해당 index를 출력해줍니다.
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch mainview.segmentedControl.selectedSegmentIndex {
        case 0:
            chartsAppearDays()
        case 1:
            chartsAppearWeeks()
        case 2:
            chartsAppearMonths()
        default:
            chartsAppearDays()
        }
        print("\(sender.selectedSegmentIndex)")
    }
    
    func setBarChartDays(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "일별 공부 시작시간")

        // 차트 컬러
        chartDataSet.colors = [themaChoice().progressColor]
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        mainview.barChartView.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        mainview.barChartView.doubleTapToZoomEnabled = false
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        mainview.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        // 오른쪽 레이블 제거
        mainview.barChartView.rightAxis.enabled = false
        //옵션 애니메이션
        mainview.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }

    func setBarChartWeeks(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "주간 공부 시간")

        // 차트 컬러
        chartDataSet.colors = [themaChoice().progressColor]
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        mainview.barChartView.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        mainview.barChartView.doubleTapToZoomEnabled = false
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        mainview.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        // 오른쪽 레이블 제거
        mainview.barChartView.rightAxis.enabled = false
        //옵션 애니메이션
        mainview.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setBarChartMonths(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 집중 시간")

        // 차트 컬러
        chartDataSet.colors = [themaChoice().progressColor]
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        mainview.barChartView.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        mainview.barChartView.doubleTapToZoomEnabled = false
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        mainview.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        // 오른쪽 레이블 제거
        mainview.barChartView.rightAxis.enabled = false
        //옵션 애니메이션
        mainview.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
}



