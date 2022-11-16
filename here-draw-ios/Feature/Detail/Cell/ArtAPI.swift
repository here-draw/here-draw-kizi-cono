//
//  ArtAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import Alamofire

class ArtAPI {
    // 작품 상세 조회
    static func detailArtInfo(artId: Int, onCompletion: @escaping (ArtInfoResult) -> Void) {
        let url = NetworkUtils.baseURL + "/arts" + "/\(artId)"
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": NetworkUtils.jwt!]
        
        print(url)
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: ArtInfoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = data.message
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
    
    // 작가의 작품 목록 조회
    static func artistArts(from viewType: ArtistArtsViewType, onCompletion: @escaping (OtherArtsResult) -> Void) {
        
        let url = viewType.url
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": NetworkUtils.jwt!]
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: OtherArtsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = data.message
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
