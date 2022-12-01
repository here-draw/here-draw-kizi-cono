//
//  ArticleCompilationAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import Foundation
import Alamofire

class ArticleCompilationAPI{
    // 메인 배너 목록 조회
    static func articleBanners(onCompletion: @escaping ([ArticleBannerResult]) -> Void) {
        
        let url = NetworkUtils.baseURL + "/articles/banners"
        guard let jwt = NetworkUtils.jwt else {
            print("메인 배너 목록 조회 " + "jwt가 없어 요청을 중단합니다.")
            return
        }
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : jwt]
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: ArticleBannerResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = "메인 배너 목록 조회 " + data.message
                    if data.isSuccess {
                        print(message)
                        onCompletion(data.result!)
                    } else {
                        print("실패: \(message)")
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
}
