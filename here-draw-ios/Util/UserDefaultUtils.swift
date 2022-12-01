//
//  UserDefaultUtils.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/28.
//

import Foundation

enum SocialLoginType: Codable {
    case kakao
    case apple
}

struct UserDefaultUtils {
    public static var appleIdentityToken: String? {
        didSet {
            UserDefaults.standard.set(appleIdentityToken, forKey: "appleIdentityToken")
        }
    }
    
    @UserDefault(key: "loginType", defaultValue: SocialLoginType.kakao)
    public static var loginType: SocialLoginType
    
    public static var jwt: String? {
        didSet {
            UserDefaults.standard.set(jwt, forKey: "jwt")
            NetworkUtils.jwt = jwt
        }
    }

    public static var nickname: String? {
        didSet {
            UserDefaults.standard.set(nickname, forKey: "nickname")
        }
    }
    
    public static func saveKakaoLoginInfo(_ jwt: String?, _ nickname: String?) {
        UserDefaultUtils.loginType = .kakao
        UserDefaultUtils.jwt = jwt
        UserDefaultUtils.nickname = nickname
    }
    
    public static func saveAppleLoginInfo(_ appleIdentityToken: String, _ jwt: String?, _ nickname: String?) {
        UserDefaultUtils.loginType = .apple
        UserDefaultUtils.appleIdentityToken = appleIdentityToken
        UserDefaultUtils.jwt = jwt
        UserDefaultUtils.nickname = nickname
    }
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults

    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
