//
//  MessageViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

import SnapKit
import Then

class MessageViewController: BaseViewController {
    let stompManager = StompManager()
    
    private weak var connectButton: UIButton!
    private weak var sendMessageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override func setLayout() {
        connectButton = UIButton().then {
            $0.backgroundColor = .pastelYellow
            $0.setTitle("connect socket", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(connect(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(200)
                $0.height.equalTo(50)
                
            }
        }
        
        sendMessageButton = UIButton().then {
            $0.backgroundColor = .pastelYellow
            $0.setTitle("send message", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(send(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(connectButton.snp.bottom).offset(50)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(200)
                $0.height.equalTo(50)
                
            }
        }
    }
    
    @objc func connect(_ sender: UIButton) {
        stompManager.registerSockect()
    }
    
    @objc func send(_ sender: UIButton) {
        stompManager.sendMessage()
    }

}
