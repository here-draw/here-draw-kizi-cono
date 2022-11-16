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
    private var otherArts: OtherArtsResult?
    private var recommendedArts: [String: Any] = [:]
    
    
    // MARK: - Functions
    
    // fetch Art info
    func fetchArtInfo(artId: Int) {
        ArtAPI.detailArtInfo(artId: artId) { artInfo in
            self.artInfo = artInfo
            print(self.artInfo!)
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
}
