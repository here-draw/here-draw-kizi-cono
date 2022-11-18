//
//  ArticleResponse.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import Foundation
import Alamofire

// MARK: - ArticleResponse
struct ArticleResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: result?
}

// MARK: - result
struct result: Decodable {
    let articleId: Int?
    let artistId: Int?
    let thumbnailImage: String?
    let articleTitle: String?
    let artistName: String?
    let description: String?
}
