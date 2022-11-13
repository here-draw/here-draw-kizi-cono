//
//  StompManager.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/13.
//

import StompClientLib

class StompManager {
    // Socket Client instance
    var socketClient = StompClientLib()
    
    // Socket Connection URL
    private let url = URL(string: "wss://dev.leesyum.shop/chat")!
    
    // Socket Connection
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url),
            delegate: self
            /*connectionHeaders: ["X-ACCESS-TOKEN" : NetworkUtils.jwt!]*/
        )
    }
    
    // Stomp 클라이언트가 특정 Topic (Destination)을 구독하는 함수
    /// sub가 subscribe prefix이고, 나머지 부분이 Destination
    /// ex) socketClient.subscribe(destination: "/sub/chat/room/"  + chatId)
    func subscribe() {
        socketClient.subscribe(destination: "pub/chat")
    }
    
    // Publish Message(함수가 실행되면 해당 토픽을 구독중인 클라이언트들이 메시지를 받을 수 있음)
    /// pub가 publish prefix이고, 나머지 부분이 publish url
    /// ex) toDestination: "/pub/chat/message
    func sendMessage() {
        var payloadObject : [String : Any] = [
            "roomId": 2,
            "senderId": 4,
            "receiverId": 6,
            "message": "안녕하세요 test 메시지입니다."
        ]
        
        socketClient.sendJSONForDict(
            dict: payloadObject as AnyObject,
            toDestination: "pub/chat/message")
    }
    
    // Unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }
}

// MARK: Extension StompClientLibDelegate

extension StompManager : StompClientLibDelegate {
    func stompClient(
        client: StompClientLib!,
        didReceiveMessageWithJSONBody jsonBody: AnyObject?,
        akaStringBody stringBody: String?,
        withHeader header: [String : String]?,
        withDestination destination: String
    ) {
        // TODO: jsonbody 파싱
        print("1: \(jsonBody)")
    }
    
    func stompClientJSONBody(
        client: StompClientLib!,
        didReceiveMessageWithJSONBody jsonBody: String?,
        withHeader header: [String : String]?,
        withDestination destination: String
    ) {
        print("2: \(jsonBody)")
    }
    
    // Unsubscribe Topic
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket is disconnected")
    }
    
    // Subscribe Topic after Connection
    func stompClientDidConnect(client: StompClientLib!) {
        print("Stomp socket is connected")
        
        subscribe()
    }
    
    // Error - disconnect and reconnect socket
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error send : " + description)
        
        socketClient.disconnect()
        registerSockect()
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
}
