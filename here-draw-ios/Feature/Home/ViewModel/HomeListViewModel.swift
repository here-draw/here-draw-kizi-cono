//
//  HomeListViewModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/19.
//

import UIKit

class HomeListViewModel {
    private var mainArtsResult: MainArtsResult?
    
    func fetchMainArts(type: MainArtsViewType, onCompletion: @escaping ((Bool) -> Void)) {
        ArtAPI.mainArts(type: type) { mainArtsResult in
            switch type {
            case .firstLoad(let _):
                self.mainArtsResult = mainArtsResult
                print(mainArtsResult)
                onCompletion(self.mainArtsResult!.hasNextScroll)
            case .reload(let _, let _, let _):
                self.mainArtsResult?.hasNextScroll = mainArtsResult.hasNextScroll
                self.mainArtsResult?.artIdCursor = mainArtsResult.artIdCursor
                self.mainArtsResult?.dateCursor = mainArtsResult.dateCursor
                self.mainArtsResult?.artInfoList += mainArtsResult.artInfoList
                onCompletion(self.mainArtsResult!.hasNextScroll)
            }
        }
    }
    
    func cursor() -> (Int, String) {
        return (mainArtsResult!.artIdCursor, mainArtsResult!.dateCursor)
    }
    
    func artInfoList() -> [ArtInfoList] {
        return mainArtsResult!.artInfoList
    }
}
