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
    
    private var fetchDone = [Bool](repeating: false, count: 4)
    
    public var sales: Bool = false
    public var myArt: Bool = false
    public var likes: Bool = false
    public var likeCount: Int = 0
    
    
    // MARK: - Functions
    
    func fetchData(artId: Int, artistId: Int, onCompletion: @escaping (() -> Void)) {
        fetchArtInfo(artId: artId) {
            self.fetchDone[0] = true
            if self.fetchDone.allSatisfy({ $0 == true }) { onCompletion() }
        }
        fetchArtistInfo(artistId: artistId) {
            self.fetchDone[1] = true
            if self.fetchDone.allSatisfy({ $0 == true }) { onCompletion() }
        }
        fetchOtherArts(artistId: artistId, artId: artId) {
            self.fetchDone[2] = true
            if self.fetchDone.allSatisfy({ $0 == true }) { onCompletion() }
        }
        fetchRecommendedArts(artId: artId) {
            self.fetchDone[3] = true
            if self.fetchDone.allSatisfy({ $0 == true }) { onCompletion() }
        }
    }
    
    // fetch Art info
    func fetchArtInfo(artId: Int, onCompletion: @escaping (() -> Void)) {
        ArtAPI.detailArtInfo(artId: artId) { artInfo in
            self.artInfo = artInfo
            print(self.artInfo!)
            self.sales = artInfo.sales
            self.myArt = artInfo.myArt
            self.likes = artInfo.likes
            self.likeCount = artInfo.likeCount
            onCompletion()
        }
    }
    
    // fetch Artist info
    func fetchArtistInfo(artistId: Int, onCompletion: @escaping (() -> Void)) {
        UserAPI.artistInfo(artistId: artistId) { artistInfo in
            self.artistInfo = artistInfo
            print(self.artistInfo!)
            onCompletion()
        }
    }
    
    
    // fetch other Arts
    func fetchOtherArts(artistId: Int, artId: Int, onCompletion: @escaping (() -> Void)) {
        ArtAPI.artistArts(from: .detailArt(artistId, artId)) { otherArts in
            self.otherArts = otherArts
            print(self.otherArts!)
            onCompletion()
        }
    }
    
    // fetch recommended Arts
    func fetchRecommendedArts(artId: Int, onCompletion: @escaping (() -> Void)) {
        ArtAPI.recommendedArts(from: .detailArt(artId)) { recommendedArts in
            self.recommendedArts = recommendedArts
            print(self.recommendedArts!)
            onCompletion()
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
            sales: artInfo!.sales,
            profileImage: artistInfo!.profileImg,
            nickname: artistInfo!.nickname
        )
    }
    
    // DetailTableViewController에 필요한 데이터 전달
    func detailArtInfoData() -> DetailArtInfoData {
        return DetailArtInfoData(
            copyright: artInfo!.copyright,
            description: artInfo!.description
        )
    }
    
    func artHashtagData() -> ArtHashtagData {
        return ArtHashtagData(hashtags: artInfo!.tag)
    }
    
    func artistInfoData() -> ArtistInfoData {
        return ArtistInfoData(
            nickname: artistInfo!.nickname,
            profileImg: artistInfo!.profileImg,
            description: artistInfo!.description,
            followerCnt: artistInfo!.followerCnt,
            isFollowing: artistInfo!.isFollowing,
            likeCnt: artistInfo!.likeCnt,
            myArt: artInfo!.myArt
        )
    }
    
    func otherArtsData() -> ArtsData {
        return ArtsData(artList: otherArts!.artList)
    }
    
    func recommendedArtsData() -> RecommendedArtsData {
        return RecommendedArtsData(artList: recommendedArts!)
    }
}
