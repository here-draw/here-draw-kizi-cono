//
//  ArtDetailView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/14.
//

import UIKit

import SnapKit
import Then

class ArtDetailView: BaseView {
    
    // MARK: - Properties
    
    private var currentIndex = 0 {
        didSet { updateTabButton() }
    }
    
    // 헤더뷰
    /// ㄴ 탭 스택뷰
    ///  ㄴ 작품 정보 탭 버튼
    ///  ㄴ 작가님 정보 탭 버튼
    /// ㄴ bar의 백그라운드 line 뷰
    /// ㄴ 현재 정보 bar 뷰
    public weak var headerView: UIView!
    private weak var tabStackView: UIStackView!
    private weak var artTabButton: UIButton!
    private weak var artistTabButton: UIButton!
    private weak var barBackgroundView: UIView!
    private weak var barView: UIView!
    
    // 스크롤뷰>스택뷰
    public weak var scrollView: UIScrollView!
    private weak var contentStackView: UIStackView!
//
//
//    // ㄴ작품정보 컨텐츠 뷰
//    /// ㄴ 작룸 정보 뷰
//    /// ㄴ 작품 해시태그 뷰
//    private weak var artContentView: UIView!
//    private weak var artInfoView: UIView!
//    private weak var artHashtagView: UIView!
//
//
//    // ㄴ작가님 정보 컨텐츠 뷰
//    /// ㄴ 작가 정보 컨텐츠 뷰
//    /// ㄴ 작가 다른 작품 컬렉션 뷰
//    /// ㄴ 추천 작품 컬렉션 뷰
//    private weak var artistContentView: UIView!
//    private weak var artistInfoView: UIView!
//    private weak var artistArtsView: UIView!
//    private weak var recommendArtsView: UIView!
    
    
    
    // MARK: - Functions
    
    private func updateTabButton() {
        barView.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(CGFloat(currentIndex) * barView.frame.width)
        }
    }
    
    override func setLayout() {
        self.backgroundColor = .mediumBlack
        
        headerView = UIView().then {
            backgroundColor = .mediumBlack
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
        }
        
        tabStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.backgroundColor = .clear
            headerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        artTabButton = UIButton().then {
            $0.setTitle("작품정보", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .sfPro16Pt4
            $0.addTarget(self, action: #selector(selectTabButton(_:)), for: .touchUpInside)
            tabStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().dividedBy(2)
            }
        }
        
        artistTabButton = UIButton().then {
            $0.setTitle("작가님 정보", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .sfPro16Pt4
            $0.addTarget(self, action: #selector(selectTabButton(_:)), for: .touchUpInside)
            tabStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
        
        barBackgroundView = UIView().then {
            $0.backgroundColor = .mediumGrey
            headerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
        
        barView = UIView().then {
            $0.backgroundColor = .pastelYellow
            barBackgroundView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
            }
        }
        
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(headerView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    @objc
    func selectTabButton(_ sender: UIButton) {
        currentIndex = sender === artTabButton ? 0: 1
    }
}
