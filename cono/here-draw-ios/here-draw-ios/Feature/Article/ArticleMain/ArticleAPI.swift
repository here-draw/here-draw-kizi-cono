//
//  ArticleAPI.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import Foundation
import Alamofire


class ArticleAPI {
    static func article(onCompletion: @escaping (ArticleResponse?) -> Void) {
        let url = "/articles"
        let jwt = "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NjY1MTIxMTEsImV4cCI6MTY2Nzk4MzMzOX0.9LADPNUg35YYTGdRBE6n9YKTeNqV_G1_5EqzaWIdOIU"
        AF.request(url, method: .get, headers: ["X-ACCESS-TOKEN": jwt])
            .validate().responseDecodable(of: ArticleResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    let message = data.message
                    if data.isSuccess {
                        print(message)
                        onCompletion(data)
                    } else {
                        print("실패: \(message)")
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
}
