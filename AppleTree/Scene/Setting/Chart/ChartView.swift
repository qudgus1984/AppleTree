//
//  ChartView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/26.
//

import UIKit
import Charts

class ChartView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().lightColor
        return view
    }()

    var barChartView: BarChartView = {
        let view = BarChartView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()
    
    var segmentedControl: UISegmentedControl = {
        let items = ["일", "주", "월"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    
    

    
    override func configure() {
        [bgView, segmentedControl, barChartView].forEach {
        self.addSubview($0)
        }
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)

        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(300)
            make.centerX.equalTo(bgView)
        }
    }
}
