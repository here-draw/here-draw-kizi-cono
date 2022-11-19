//
//  LoadingCollectionReusableView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/19.
//

import UIKit

class LoadingCollectionReusableView: UICollectionReusableView {
    
    public weak var loadingIndicator: UIActivityIndicatorView!
    
    func setLayout() {
        
        loadingIndicator = UIActivityIndicatorView(style: .large).then{
            $0.isHidden = true
            $0.color = .gray
            self.addSubview($0)
            
            $0.snp.makeConstraints{
                $0.centerX.centerY.equalToSuperview()
            }
        }
    }
}
