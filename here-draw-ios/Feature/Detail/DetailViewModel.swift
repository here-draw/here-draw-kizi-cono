//
//  DetailViewModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

class DetailViewModel {
    
    // MARK: - Properties
    
    private var artInfo: ArtInfoResult?
    private var artistInfo: ArtistInfoResult?
    private var otherArts: ArtistArtsResult?
    private var recommendedArts: [RecommendedArtsResult]?
    
    public var sales: Bool = false
    public var myArt: Bool = false
    public var likeCount: Int = 0
    
    
    // MARK: - Functions
    
    func fetchData(artId: Int, artistId: Int) {
//        fetchArtInfo(artId: artId)
        fetchArtistInfo(artistId: artistId)
        fetchOtherArts(artistId: artistId, artId: artId)
        fetchRecommendedArts(artId: artId)
    }
    
    // fetch Art info
    func fetchArtInfo(artId: Int, onCompletion: @escaping (() -> Void)) {
        ArtAPI.detailArtInfo(artId: artId) { artInfo in
            self.artInfo = artInfo
            print(self.artInfo!)
            self.sales = artInfo.sales
            self.myArt = artInfo.myArt
            print(artInfo.like)
            self.likeCount = artInfo.like
            onCompletion()
        }
    }
    
    // fetch Artist info
    func fetchArtistInfo(artistId: Int) {
        UserAPI.artistInfo(artistId: artistId) { artistInfo in
            self.artistInfo = artistInfo
            print(self.artistInfo!)
        }
    }
    
    
    // fetch other Arts
    func fetchOtherArts(artistId: Int, artId: Int) {
        ArtAPI.artistArts(from: .detailArt(artistId, artId)) { otherArts in
            self.otherArts = otherArts
            print(self.otherArts!)
        }
    }
    
    // fetch recommended Arts
    func fetchRecommendedArts(artId: Int) {
        ArtAPI.recommendedArts(from: .detailArt(artId)) { recommendedArts in
            self.recommendedArts = recommendedArts
            print(self.recommendedArts!)
        }
    }
    
    // artHeaderView에 필요한 데이터 전달
    func artHeaderView() -> ArtHeaderViewData {
        return ArtHeaderViewData(
            artImage: artInfo!.artImage,
            width: artInfo!.width,
            height: artInfo!.height,
            title: artInfo!.title,
            simpleDescription: artInfo!.simpleDescription,
            price: artInfo!.price,
            filetype: artInfo!.filetype,
            sales: artInfo!.sales
        )
    }
}
