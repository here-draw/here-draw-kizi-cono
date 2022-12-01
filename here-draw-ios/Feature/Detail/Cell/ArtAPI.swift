//
//  ArtAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import Alamofire

class ArtAPI {
    // 메인: 작품 목록 조회
    static func mainArts(type viewType: MainArtsViewType, onCompletion: @escaping (MainArtsResult) -> Void) {
        let url = viewType.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let jwt = NetworkUtils.jwt else {
            print("메인: 작품 목록 조회 " + "jwt가 없어 요청을 중단합니다.")
            return
        }
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": jwt]
//        print("jwt -------> \(headers.value(for: "X-ACCESS-TOKEN"))")
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: MainArtsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = "메인: 작품 목록 조회 " + data.message
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
    
    // 작품 상세 조회
    static func detailArtInfo(artId: Int, onCompletion: @escaping (ArtInfoResult) -> Void) {
        let url = NetworkUtils.baseURL + "/arts" + "/\(artId)"
        guard let jwt = NetworkUtils.jwt else {
            print("작품 상세 조회 " + "jwt가 없어 요청을 중단합니다.")
            return
        }
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": jwt]
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: ArtInfoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = "작품 상세 조회 " + data.message
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
    static func artistArts(from viewType: ArtistArtsViewType, onCompletion: @escaping (ArtistArtsResult) -> Void) {
        
        let url = viewType.url
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": NetworkUtils.jwt ?? ""]
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: ArtistArtsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = "작가의 작품 목록 조회 " + data.message
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
    
    // 추천 작품 목록 조회
    static func recommendedArts(from viewType: RecommendedArtsViewType, onCompletion: @escaping ([RecommendedArtsResult]) -> Void) {
        
        let url = viewType.url
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": NetworkUtils.jwt ?? ""]
        
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: RecommendedArtsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = "추천 작품 목록 조회 " + data.message
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
