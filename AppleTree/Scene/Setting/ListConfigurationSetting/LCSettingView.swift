//
//  LCSetting.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/22.
//

import Foundation
import UIKit
import SnapKit




final class LCSettingView: BaseView {
    
    lazy var colletcionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    

    override func configure() {
        [colletcionView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstants() {
 
        colletcionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}
