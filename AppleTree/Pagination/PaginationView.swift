//
//  PaginationView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit
import SnapKit

final class PaginationView: BaseView {
    

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()
    

    
    let explainLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = FontChoice().Font36
        label.textColor = .white
        return label
    }()

    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = themaChoice().lightColor
        return view
    }()
    
    
    


    override func configure() {
        [bgView, explainLabel, imageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(bgView.snp.height).multipliedBy(0.35)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(explainLabel.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(imageView.snp.width)
        }
    }
}
