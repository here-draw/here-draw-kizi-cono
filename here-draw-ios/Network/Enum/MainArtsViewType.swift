//
//  MainArtsViewType.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/19.
//

import Foundation

enum MainArtsViewType {
    case firstLoad(String)    // 첫번째 호출
    case reload(String, Int, String)  // n번째 호출(n>=2)
    
    var url: String {
        switch self {
        case .firstLoad(let category):
            return NetworkUtils.baseURL + "/arts" + "?category=\(category)" + "&size=10"
        case .reload(let category, let id, let date):
            return NetworkUtils.baseURL + "/arts" + "?category=\(category)" + "&id=\(id)" + "&date=\(date)" + "&size=10"
        }
    }
}
