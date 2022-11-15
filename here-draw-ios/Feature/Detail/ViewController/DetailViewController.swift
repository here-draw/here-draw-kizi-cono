//
//  DetailViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/13.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private weak var backButton: UIButton!
    private weak var rightBarButton: UIButton!  // 내 작품 ? 작품 수정 버튼: 작품 신고 버튼
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var artHeaderView: ArtHeaderView!
    private weak var artDetailView: ArtDetailView!
    private weak var artFooterView: UIView!
    private weak var inquiryFloatingButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func setLayout() {
        view.backgroundColor = .black1
        
        artFooterView = UIView().then {
            $0.backgroundColor = .pastelYellow
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.14)
            }
        }
        
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalTo(artFooterView.snp.top)
            }
        }
        
        stackView = UIStackView().then {
            $0.backgroundColor = .greyishMediumBrown
            $0.axis = .vertical
            $0.spacing = 10
//            $0.distribution = .fill
            scrollView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
        artHeaderView = ArtHeaderView().then {
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(656)  // 이미지 제외 높이 219
            }
        }
        
        artDetailView = ArtDetailView().then {
//            $0.backgroundColor = .green
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.height.equalTo(1519)
            }
        }
        
        backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold), forImageIn: .normal)
            $0.tintColor = .white
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.leading.equalTo(view.safeAreaLayoutGuide).inset(22)
            }
        }
        
        rightBarButton = UIButton().then {
            // TODO: API 연결 후, 내 작품 여부에 따라 아이콘 핸들링
//            $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            $0.setImage(UIImage(named: "report"), for: .normal)
            $0.tintColor = .white
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
            }
        }
        
        inquiryFloatingButton = UIButton().then {
            $0.backgroundColor = .warmBlue
            $0.layer.cornerRadius = 50 * 0.5
            $0.shadow(
                opacity: 0.53,
                color: .black,
                offset: .init(width: 0, height: 8)
            )
            
            $0.setImage(UIImage(named: "artDM")!, for: .normal)
            $0.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .bold), forImageIn: .normal)
            $0.tintColor = .white
            
            $0.setTitle("작품문의", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 7)
            $0.alignTextBelow()
            
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.bottom.equalTo(artFooterView.snp.top).offset(-20)
                $0.width.height.equalTo(50)
            }
        }
    }
}

//MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewRepresentable: UIViewRepresentable{
    typealias UIViewType = UIView
    private let vc = DetailViewController()
    
    func makeUIView(context: Context) -> UIView {
        vc.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // 데이터 로드 필요할 때
        // vc.tableView.reloadData()
    }
}

struct ViewController_Previews: PreviewProvider{
    static var previews: some View{
        ViewRepresentable()
    }
}
#endif
