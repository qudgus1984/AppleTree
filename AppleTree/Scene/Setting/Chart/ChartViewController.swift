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
    
    var months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var unitsSold: [Double]!
    var days: [String] = ["6~8", "8~10", "10~12", "12~2", "2~4", "4~6", "6~8", "8~10", "10~12", "0~2", "2~4", "4~6"]
    var weeks: [String] = ["6일 전", "5일 전", "4일 전", "3일 전", "이틀 전", "어제", "오늘"]
    
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
            DispatchQueue.main.async {
                
                self.mainview.containChartView.clipsToBounds = true
                self.mainview.containChartView.layer.cornerRadius = 25
                
                self.mainview.barChartView.clipsToBounds = true
                self.mainview.barChartView.layer.cornerRadius = 10
                
            }
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
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mainview.segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        mainview.segmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .selected)
        chartsAppearDays()

    }
    
    func chartsAppearMonths() {
        
        let JanMonth = DateComponents(year: 2022, month: 1, day: 01)
        let FebMonth = DateComponents(year: 2022, month: 2, day: 01)
        let MarMonth = DateComponents(year: 2022, month: 3, day: 01)
        let AprMonth = DateComponents(year: 2022, month: 4, day: 01)
        let MayMonth = DateComponents(year: 2022, month: 5, day: 01)
        let JunMonth = DateComponents(year: 2022, month: 6, day: 01)
        let JulMonth = DateComponents(year: 2022, month: 7, day: 01)
        let AugMonth = DateComponents(year: 2022, month: 8, day: 01)
        let SepMonth = DateComponents(year: 2022, month: 9, day: 01)
        let OctMonth = DateComponents(year: 2022, month: 10, day: 01)
        let NovMonth = DateComponents(year: 2022, month: 11, day: 01)
        let DecMonth = DateComponents(year: 2022, month: 12, day: 01)

//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: JanMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: FebMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: MarMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: AprMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: MayMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: JunMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: JulMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: AugMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: SepMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: OctMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: NovMonth))), Double(repository.monthTotalTimeFilter(date: componentChangedDate(Date: DecMonth)))]
        

        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        
        
        setBarChartMonths(dataPoints: months, values: unitsSold)
        
        
    }
    
    func componentChangedDate(Date: DateComponents) -> Date {
        let startDate = Calendar.current.date(from: Date)!
        return startDate
    }
    
    func chartsAppearDays() {
        let calender = Calendar.current
//        days = ["6~8", "8~10", "10~12", "12~14", "14~16", "16~18", "18~20", "20~22", "22~24", "24~2", "2~4", "4~6"]
        unitsSold = [Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*3).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*4).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*5).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*6).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*7).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*8).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*9).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*10).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*11).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*1).count), Double(repository.twoHourTimeFilter(date: calender.startOfDay(for: Date())+7200*2).count)]
        
        mainview.barChartView.xAxis.labelRotationAngle = -15
        mainview.barChartView.leftAxis.setLabelCount(6, force: true)


        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        setBarChartDays(dataPoints: days, values: unitsSold)
        mainview.barChartView.xAxis.drawAxisLineEnabled = true
        mainview.barChartView.xAxis.drawGridLinesEnabled = false
        mainview.barChartView.xAxis.granularityEnabled = false
    }
    
    func chartsAppearWeeks() {
        
        
        unitsSold = [Double(repository.dayTotalTimeFilter(date: Date()-86400*6)),Double(repository.dayTotalTimeFilter(date: Date()-86400*5)),Double(repository.dayTotalTimeFilter(date: Date()-86400*4)),Double(repository.dayTotalTimeFilter(date: Date()-86400*3)),Double(repository.dayTotalTimeFilter(date: Date()-86400*2)),Double(repository.dayTotalTimeFilter(date: Date()-86400*1)),Double(repository.dayTotalTimeFilter(date: Date()))]
        
        let rightAxis = mainview.barChartView.rightAxis
        rightAxis.enabled = false
        
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
//         데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "일별 공부 시작시간(count)")


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
        
        
        // X축 레이블 위치 조정
        mainview.barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        mainview.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        
        // 미니멈
        mainview.barChartView.leftAxis.axisMinimum = 0
        
        let rightAxis = mainview.barChartView.rightAxis
        rightAxis.enabled = false
        
    }

    func setBarChartWeeks(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "주간 공부 시간(minute)")

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
        
        // X축 레이블 위치 조정
        mainview.barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        mainview.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: weeks)
        
        // 미니멈
        mainview.barChartView.leftAxis.axisMinimum = 0
        
        let rightAxis = mainview.barChartView.rightAxis
        rightAxis.enabled = false
    }
    
    func setBarChartMonths(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 집중 시간(minute)")

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
        
        // X축 레이블 위치 조정
        mainview.barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        mainview.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        // 미니멈
        mainview.barChartView.leftAxis.axisMinimum = 0
        
        let rightAxis = mainview.barChartView.rightAxis
        rightAxis.enabled = false
    }
}



