//
//  OtherArtsViewType.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

enum ArtistArtsViewType {
    case artistHome(Int)
    case myPage(Int)
    case detailArt(Int, Int)
    case articleCompilation(Int)
    
    var url: String {
        switch self {
        case .artistHome(let artistId):
            return NetworkUtils.baseURL + "/users" + "/\(artistId)" + "/arts"
        case .myPage(let artistId):
            return NetworkUtils.baseURL + "/users" + "/\(artistId)" + "/arts" + "?type=my"
        case .detailArt(let artistId, let artId):
            return NetworkUtils.baseURL + "/users" + "/\(artistId)" + "/arts" + "?art-id=\(artId)" + "&size=4"
        case .articleCompilation(let artistId):
            return NetworkUtils.baseURL + "/users" + "/\(artistId)" + "/arts" + "?size=2"
        }
    }
}
