//
//  Thema enum + func.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/19.
//

import UIKit

enum Thema {
    case SeSACThema
    case PurpleThema
    
    var mainColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntGreen
        case .PurpleThema:
            return .huntPurple
        }
    }
    
    var lightColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntLightGreen
        case .PurpleThema:
            return .huntLightPurple
        }
    }
    
    var progressColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntYellow
        case .PurpleThema:
            return .huntPurpleWhite
        }
    }
    
    var calendarChoiceColor: UIColor {
        switch self {
        case .SeSACThema:
            return .customDarkGreen
        case .PurpleThema:
            return .huntPurpleBlue
        }
    }
}

func themaChoice() -> Thema {
    if UserDefaults.standard.integer(forKey: "thema") == 0 {
        return Thema.SeSACThema
    } else {
        return Thema.PurpleThema
    }
}
