//
//  ArticleBannerResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

struct ArticleBannerResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ArticleBannerResult]?
}

// MARK: - Result
struct ArticleBannerResult: Decodable {
    let articleId: Int
    let bannerImage: String
}
