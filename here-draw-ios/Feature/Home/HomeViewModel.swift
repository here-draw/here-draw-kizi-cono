//
//  HomeViewModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

class HomeViewModel {
    public var articleBanners: [ArticleBannerResult]?
    
    // fetch banner images
    func fetchBanners(onCompletion: @escaping (() -> Void)) {
        ArticleCompilationAPI.articleBanners() { banners in
            self.articleBanners = banners
            print(self.articleBanners!)
            onCompletion()
        }
    }
    
    // fetch artList
}
