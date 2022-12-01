//
//  AppDelegate.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/12.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let nativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        
        KakaoSDK.initSDK(appKey: nativeAppKey as! String)
        
        print("")
        print("===============================")
        print("[AppDelegate >> didFinishLaunchingWithOptions]")
        print("설명 :: 앱 프로세스 완료 및 앱 실행 실시")
        print("===============================")
        print("")
        
        // [SEARCH FAST] : [푸시 알림 뱃지 카운트 초기화]
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        // [SEARCH FAST] : [파이어베이스 초기화]
        FirebaseApp.configure() // [Firebase 라이브러리 초기화]
        Messaging.messaging().delegate = self // [메시징 딜리게이트 지정]
        UNUserNotificationCenter.current().delegate = self // [노티피케이션 알림 딜리게이트 지정]
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // [푸시 알림 권한]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (success, error) in // [푸시 알림 권한 요청]
            // [success 부분에 권한을 허락하면 true / 권한을 허락하지 않으면 false 값이 들어갑니다]
            if let error = error {
                print("")
                print("===============================")
                print("[AppDelegate >> requestAuthorization() :: 노티피케이션 권한 요청 에러]")
                print("[error :: \(error.localizedDescription)]")
                print("===============================")
                print("")
            }
            else {
                print("")
                print("===============================")
                print("[AppDelegate >> requestAuthorization() :: 노티피케이션 권한 요청 응답 확인]")
                print("[success :: \(success)]")
                print("===============================")
                print("")
            }
        }
        
        application.registerForRemoteNotifications() // [원격 알림 앱 등록 : APNS 등록]
        print("")
        print("===============================")
        print("[AppDelegate >> didFinishLaunchingWithOptions]")
        print("설명 :: ", "파이어베이스 초기화 수행 실시")
        print("===============================")
        print("")
        
        
        // [SEARCH FAST] : [파이어베이스 등록 토큰 확인]
        Messaging.messaging().token { token, error in
            if let error = error {
                print("")
                print("===============================")
                print("[AppDelegate >> didFinishLaunchingWithOptions]")
                print("설명 :: ", "파이어베이스 등록된 토큰 확인 실패")
                print("error :: \(error)")
                print("===============================")
                print("")
            }
            else if let token = token {
                print("")
                print("===============================")
                print("[AppDelegate >> didFinishLaunchingWithOptions]")
                print("설명 :: ", "파이어베이스 등록된 토큰 확인 성공")
                print("token :: \(token)")
                print("===============================")
                print("")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    // MARK: - [Scene 만들기 위한 구성 객체 반환 : 스토리보드 , info]
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - [Scene 구성 객체 해제 실시]
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - [애플리케이션 사용자가 작업 태스크 날린 이벤트 감지]
    func applicationWillTerminate(_ application: UIApplication) {
        print("")
        print("===============================")
        print("[AppDelegate >> applicationWillTerminate]")
        print("설명 :: 애플리케이션 사용자가 작업 태스크 날린 이벤트 감지")
        print("===============================")
        print("")
    }
    
    
    
    // MARK: - [원격 알림 앱 등록 : APNS 등록 후 >> apnsToken 매핑]
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)}) // hex 데이터 확인
        print("")
        print("===============================")
        print("[AppDelegate >> didRegisterForRemoteNotificationsWithDeviceToken]")
        print("설명 :: 원격 알림 앱 등록 : APNS 등록 후 >> apnsToken 매핑")
        print("deviceToken :: \(deviceToken)")
        print("===============================")
        print("")
        Messaging.messaging().apnsToken = deviceToken // 토큰 매핑
    }
}

// MARK: - [노티피케이션 알림 딜리게이트 추가]
// [SEARCH FAST] : [포그라운드 백그라운드 알림 창 표시]
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // [앱이 foreground 상태 일 때, 알림이 온 경우]
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("")
        print("===============================")
        print("[AppDelegate >> willPresent]")
        print("설명 :: 앱 포그라운드 상태 푸시 알림 확인")
        print("userInfo :: \(notification.request.content.userInfo)") // 푸시 정보 가져옴
        print("title :: \(notification.request.content.title)") // 푸시 정보 가져옴
        print("body :: \(notification.request.content.body)") // 푸시 정보 가져옴
        print("===============================")
        print("")
        
        // [SEARCH FAST] : [AppDelegate 포그라운드 푸시 메시지 송신]
        DispatchQueue.main.async {
            print("")
            print("===============================")
            print("[AppDelegate >> willPresent]")
            print("설명 :: 노티피케이션 알림 송신")
            print("===============================")
            print("")
            
            // [노티피케이션 알림 전송 실시 :: 포그라운드 상태에서 푸시 메시지가 오면 해당 뷰컨트롤러에서 알림 팝업창 표시]
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "notiData"), // 알림을 식별하는 태그
                object: nil, // 발송자가 옵저버에게 보내려고 하는 객체
                userInfo: ["body" : "\(notification.request.content.body)"] // 객체의 저장소 [AnyHashable: Any] 형태
            )
        }
        
        // [completionHandler : 푸시 알림 상태창 표시]
        // completionHandler([.banner, .list, .badge, .sound])
        completionHandler([.alert, .badge, .sound])
    }
    
    // [앱이 background 상태 일 때, 알림이 온 경우]
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("")
        print("===============================")
        print("[AppDelegate >> didReceive]")
        print("앱 백그라운드 상태 푸시 알림 확인")
        print("userInfo :: \(response.notification.request.content.userInfo)") // 푸시 정보 가져옴
        print("title :: \(response.notification.request.content.title)") // 푸시 정보 가져옴
        print("body :: \(response.notification.request.content.body)") // 푸시 정보 가져옴
        print("===============================")
        print("")
        
        // [completionHandler : 푸시 알림 상태창 표시]
        completionHandler()
    }
}



// MARK: - [MessagingDelegate 딜리게이트 추가]
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("")
        print("===============================")
        print("[AppDelegate >> messaging]")
        print("설명 :: 파이어베이스 등록 토큰 확인")
        print("fcmToken :: \(String(describing: fcmToken))")
        print("===============================")
        print("")
        
        // [노티피케이션 브로드 캐스팅 알림 호출]
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}

