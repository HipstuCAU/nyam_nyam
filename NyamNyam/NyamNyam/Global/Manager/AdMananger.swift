//
//  AdMananger.swift
//  NyamNyam
//
//  Created by 한택환 on 3/9/24.
//

import GoogleMobileAds

enum AdmobBanner {
    case appBottom
    
    var unitID: String {
#if DEBUG
        return "ca-app-pub-3940256099942544/2435281174"
#else
        switch self {
        case .appBottom:
            return "ca-app-pub-2359699243056694/3320729456"
        }
#endif
    }
}
