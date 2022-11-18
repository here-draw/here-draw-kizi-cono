//
//  RecommendedArtsViewType.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

enum RecommendedArtsViewType {
    case search
    case detailArt(Int)
    
    var url: String {
        switch self {
        case .search:
            return NetworkUtils.baseURL + "/arts/recommended"
        case .detailArt(let artId):
            return NetworkUtils.baseURL + "/arts/recommended" + "?art-id=\(artId)"
        }
    }
}
