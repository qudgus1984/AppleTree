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
    case PinkThema
    case NightThema
    case BeachThema
    
    var mainColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntGreen
        case .PurpleThema:
            return .huntPurple
        case .PinkThema:
            return .huntPink
        case .NightThema:
            return .huntNight
        case .BeachThema:
            return .huntBeach
        }
        
    }
    
    var lightColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntLightGreen
        case .PurpleThema:
            return .huntLightPurple
        case .PinkThema:
            return .huntLightPink
        case .NightThema:
            return .huntLightNight
        case .BeachThema:
            return .huntLightBeach
            
        }
    }
    
    var progressColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntYellow
        case .PurpleThema:
            return .huntPurpleWhite
        case .PinkThema:
            return .huntPinkWhite
        case .NightThema:
            return .huntNightPurple
        case .BeachThema:
            return .huntBeachWhite
        }
    }
    
    var calendarChoiceColor: UIColor {
        switch self {
        case .SeSACThema:
            return .customDarkGreen
        case .PurpleThema:
            return .huntPurpleBlue
        case .PinkThema:
            return .huntPinkRed
        case .NightThema:
            return .huntNightPink
        case .BeachThema:
            return .huntLightBeachSky
        }
    }
}

func themaChoice() -> Thema {
    if UserDefaults.standard.integer(forKey: "thema") == 0 {
        return Thema.SeSACThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 1 {
        return Thema.PurpleThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 2 {
        return Thema.PinkThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 3 {
        return Thema.NightThema
    } else {
        return Thema.BeachThema
    }
}
