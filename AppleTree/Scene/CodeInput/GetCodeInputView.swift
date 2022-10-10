//
//  CodeInputView.swift
//  AppleTree
//
//  Created by 이병현 on 2022/10/02.
//

import UIKit
import SnapKit

final class GetCodeInputView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().lightColor
        return view
    }()
    
    let codeInputView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()

    let codeInputTextField: UITextField = {
       let text = UITextField()
        text.backgroundColor = themaChoice().mainColor
        text.placeholder = "쿠폰 코드를 입력하세요."
        return text
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = themaChoice().mainColor
        return button
    }()
    
    
    


    override func configure() {
        [bgView, codeInputView, codeInputTextField, finishButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstants() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        codeInputView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-120)
            make.height.equalTo(60)
        }
        codeInputTextField.snp.makeConstraints { make in
            make.edges.equalTo(codeInputView).inset(12)
        }
        
        finishButton.snp.makeConstraints { make in
            make.height.equalTo(codeInputView.snp.height)
            make.leading.equalTo(codeInputView.snp.trailing).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(codeInputView.snp.top)
        }
    }
}
