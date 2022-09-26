//
//  ChartViewController.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/26.
//

import UIKit
import Charts

class ChartViewController: BaseViewController {
    let mainview = ChartView()
    
    var months: [String]!
    var unitsSold: [Double]!

    override func loadView() {
        super.view = mainview
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        mainview.barChartView.noDataText = "이 달의 데이터가 없어요 ㅠㅠ"
        mainview.barChartView.noDataFont = FontChoice().Font24
        mainview.barChartView.noDataTextColor = themaChoice().mainColor
        
        setBarChart(dataPoints: months, values: unitsSold)
    }
    
    override func configure() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = themaChoice().lightColor
        appearence.shadowColor = .clear

        navigationItem.standardAppearance = appearence
        navigationItem.scrollEdgeAppearance = appearence
    }
    
    func setBarChart(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")

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
        mainview.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        // 리미트라인 : 평균시간
        let ll = ChartLimitLine(limit: 10.0, label: "타겟")
        mainview.barChartView.leftAxis.addLimitLine(ll)
    }

}



