//
//  Font enum + func.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/25.
//

import UIKit

enum Font {
    case UhBeeFont
    case GangwonFont
    case LeeSeoyunFont
    case SimKyunghaFont

    
    var Font44: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont44!
        case .GangwonFont:
            return .GangwonFont44!
        case .LeeSeoyunFont:
            return .LeeSeoyunFont44!
        case .SimKyunghaFont:
            return .SimKyunghaFont44!
        
        }
    }
    
    var Font36: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont36!
        case .GangwonFont:
            return .GangwonFont36!
        case .LeeSeoyunFont:
            return .LeeSeoyunFont36!
        case .SimKyunghaFont:
            return .SimKyunghaFont36!
        }
    }
    
    var Font24: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont24!
        case .GangwonFont:
            return .GangwonFont24!
        case .LeeSeoyunFont:
            return .LeeSeoyunFont24!
        case .SimKyunghaFont:
            return .SimKyunghaFont24!
        }
    }
    
    var Font16: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont16!
        case .GangwonFont:
            return .GangwonFont16!
        case .LeeSeoyunFont:
            return .LeeSeoyunFont16!
        case .SimKyunghaFont:
            return .SimKyunghaFont16!
        }
    }
    
    var Font12: UIFont {
        switch self {
        case .UhBeeFont:
            return .UhBeeFont12!
        case .GangwonFont:
            return .GangwonFont12!
        case .LeeSeoyunFont:
            return .LeeSeoyunFont12!
        case .SimKyunghaFont:
            return .SimKyunghaFont12!
        }
    }
}

func FontChoice() -> Font {
    if UserDefaults.standard.integer(forKey: "font") == 0 {
        return Font.UhBeeFont
    } else if UserDefaults.standard.integer(forKey: "font") == 1 {
        return Font.GangwonFont
    } else if UserDefaults.standard.integer(forKey: "font") == 2 {
        return Font.LeeSeoyunFont
    } else if UserDefaults.standard.integer(forKey: "font") == 3 {
        return Font.SimKyunghaFont
    } else {
        return Font.UhBeeFont
    }
}

