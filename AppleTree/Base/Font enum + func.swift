//
//  Font enum + func.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/25.
//

import UIKit

enum Font {
    case UhBeeFont

    
    var Font44: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont44!
        }
    }
    
    var Font24: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont24!
        }
    }
    
    var Font16: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont16!
        }
    }
    
    var Font12: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont12!
        }
    }
}

func FontChoice() -> Font {
    if UserDefaults.standard.string(forKey: "Font") == "UhBee" {
        return Font.UhBeeFont
    } else {
        return Font.UhBeeFont
    }
}

