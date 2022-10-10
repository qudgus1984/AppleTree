//
//  ChartView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/26.
//

import UIKit
import Charts

final class ChartView: BaseView {
    
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
    
    var containChartView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()
    
    var segmentedControl: UISegmentedControl = {
        let items = ["일", "주", "월"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    var sucessfulLabel: UILabel = {
        let label = UILabel()
        label.text = "나무 심기 성공률 88%"
        label.font = FontChoice().Font36
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    
    override func configure() {
        [bgView, segmentedControl, sucessfulLabel, containChartView, barChartView].forEach {
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
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        sucessfulLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-40)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(80)
        }
        
        containChartView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-28)
            make.bottom.equalTo(sucessfulLabel.snp.top).offset(-28)
        }
        
        barChartView.snp.makeConstraints { make in
            make.edges.equalTo(containChartView).inset(4)
        }
    }
}
