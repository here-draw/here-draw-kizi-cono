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
    
    private weak var testButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override func setLayout() {
        testButton = UIButton().then {
            $0.backgroundColor = .pastelYellow
            $0.titleLabel?.textColor = .white
            $0.titleLabel?.text = "test"
            $0.addTarget(self, action: #selector(test(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.height.width.equalTo(50)
                
            }
        }
    }
    
    @objc func test(_ sender: UIButton) {
        stompManager.registerSockect()
    }

}
