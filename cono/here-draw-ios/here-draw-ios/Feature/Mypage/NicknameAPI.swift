//
//  NicknameAPI.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import Foundation
import Alamofire


class NicknameAPI {
    static func profile(onCompletion: @escaping (NicknameResponse?) -> Void) {
        let url = "https://dev.leesyum.shop/users/mypage/profile"
        let jwt = "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjUsImlhdCI6MTY2NzM4MTQ4NywiZXhwIjoxNjY4ODUyNzE2fQ.AOZZBszMqn32BgWRIIMmzBLf-IDUetGMoW9tPMzy7Js"
        AF.request(url, method: .get, headers: ["X-ACCESS-TOKEN": jwt])
            .validate().responseDecodable(of: NicknameResponse.self) { response in
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
