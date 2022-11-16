//
//  OtherArtsResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

struct ArtistArtsResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ArtistArtsResult?
}

struct ArtistArtsResult: Decodable {
    let count: Int
    let artList: [ArtistArtList]
}

// MARK: - ArtList
struct ArtistArtList: Decodable {
    let artId, artistId: Int
    let artImage: String
    let title: String
    let price: Int
    let like, sales: Bool
}
