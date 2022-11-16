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
    private var artistInfo: [String: Any] = [:]
    private var otherArts: [String: Any] = [:]
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
    // fetch other Arts
    // fetch recommended Arts
}
