//
//  DetailViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/13.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    let viewModel = DetailViewModel()
    public let detailTablelVC = DetailTableViewController()
    
    private weak var backButton: UIButton!
    private weak var rightBarButton: UIButton!  // 내 작품 ? 작품 수정 버튼: 작품 신고 버튼
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var artHeaderView: ArtHeaderView!
    private weak var containerView: UIView!
    private weak var artFooterView: UIView!
    private weak var likeButton: UIButton!
    private weak var likeCountLabel: UILabel!
    private weak var buyButton: UIButton!
    private weak var inquiryFloatingButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Functions
    
    func updateUI() {
        // api로부터 받은 데이터로 update 해야할 것들.
        
        // detail VC
        // - [x] rightButton (myArt) -> 버튼 이미지
        // - [x] like 여부 -> like 하트 색
        // - [x] like count -> label
        // - [x] sales -> 구매하기 버튼 색
        if viewModel.myArt {
            // TODO: 클릭 시 알럿 내용도 수정하기.
            let image = UIImage(systemName: "ellipsis")
            rightBarButton.setImage(image!, for: .normal)
            // TODO: 메시지, 팔로우 버튼 비활성화
        }
        likeCountLabel.text = "\(viewModel.likeCount)"
        
        if !viewModel.sales {
            buyButton.backgroundColor = .greyishLightBrown
            buyButton.isEnabled = false
        }
        
        likeButton.isSelected = viewModel.likes ? true: false
        
        // artHeaderView
        artHeaderView.data = viewModel.artHeaderView()
        
        // detailTableVC
        detailTablelVC.detailArtInfoData = viewModel.detailArtInfoData()
        detailTablelVC.artHashtagData = viewModel.artHashtagData()
        detailTablelVC.artistInfoData = viewModel.artistInfoData()
        detailTablelVC.otherArtsData = viewModel.otherArtsData()
        detailTablelVC.recommendedArtsData = viewModel.recommendedArtsData()
        detailTablelVC.fetchDone = true
    }
    
    override func setLayout() {
        view.backgroundColor = .mediumBlack
        
        let footerHeight = view.frame.height * 0.14
        
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//                $0.bottom.equalTo(artFooterView.snp.top)
                $0.height.equalToSuperview().multipliedBy(1 - 0.14)
            }
        }
        
        stackView = UIStackView().then {
            $0.backgroundColor = .greyishMediumBrown
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fill
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
        
        containerView = UIView().then {
            stackView.addArrangedSubview($0)
            
            self.addChild(detailTablelVC)
            $0.addSubview(detailTablelVC.view)
            detailTablelVC.didMove(toParent: self)
            
            $0.snp.makeConstraints {
                let height = DeviceUtils.height - DeviceUtils.statusBarHeight - DeviceUtils.navigationBarHeight - footerHeight
                $0.height.equalTo(height)
            }
            
            detailTablelVC.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
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
            $0.addTarget(self, action: #selector(barButtonSelected(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
            }
        }
        
        artFooterView = UIView().then {
            $0.backgroundColor = .mediumBlack
            $0.layer.shadowRadius = 5
            $0.shadow(
                opacity: 0.1,
                color: .black,
                offset: .init(width: 0, height: -10)
            )
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.14)
            }
        }
        
        buyButton = UIButton().then {
            $0.backgroundColor = .pastelYellow
            $0.layer.cornerRadius = 10
            
            $0.setTitle("구매하기", for: .normal)
            $0.setTitleColor(.mediumBlack, for: .normal)
            $0.titleLabel?.font = .sfPro22Pt
            
            artFooterView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(17)
                $0.trailing.equalToSuperview().inset(20)
                $0.width.equalToSuperview().multipliedBy(0.74)
                $0.height.equalToSuperview().multipliedBy(0.45)
            }
        }
        
        likeButton = UIButton().then {
            $0.setImage(UIImage(named: "heart"), for: .normal)
            $0.setImage(UIImage(named: "heart.fill"), for: .selected)
            $0.tintColor = $0.isSelected ? .grapefruit: .white
            artFooterView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(buyButton.snp.top).offset(7)
                $0.leading.equalToSuperview().inset(34)
                $0.width.equalTo(buyButton.snp.height).multipliedBy(0.45)
                $0.height.equalTo(buyButton.snp.height).multipliedBy(0.45)
            }
        }
        
        likeCountLabel = UILabel().then {
            $0.text = "3.1k"
            $0.font = .sfPro14Pt2
            $0.textColor = .white
            artFooterView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(likeButton.snp.bottom).offset(3)
                $0.bottom.equalTo(buyButton.snp.bottom).offset(-6).priority(.medium)
                $0.centerX.equalTo(likeButton.snp.centerX)
            }
        }
        
        inquiryFloatingButton = UIButton().then {
            $0.backgroundColor = .warmBlue
            $0.layer.cornerRadius = 50 * 0.5
            $0.shadow(
                opacity: 0.15,
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
    
    // MARK: - objc func
    @objc
    func barButtonSelected(_ sender: UIButton) {
        if viewModel.myArt {
            let alert = UIAlertController(title: "메뉴", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "수정", style: .default, handler: { _ in
                // TODO: 작품 수정 화면으로 이동
            }))
            alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { _ in
                // TODO: 작품 삭제
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            
            self.present(alert,animated: true)
        }
        else {
            let alert = UIAlertController(title: "신고 사유 선택", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "유출/사칭/사기", style: .default, handler: reportHandler))
            alert.addAction(UIAlertAction(title: "욕설/비하", style: .default, handler: reportHandler))
            alert.addAction(UIAlertAction(title: "음란물", style: .default, handler: reportHandler))
            alert.addAction(UIAlertAction(title: "기타", style: .default, handler: reportHandler))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            
            self.present(alert,animated: true)
        }
    }
    
    let reportHandler: (UIAlertAction) -> Void = { action in
        print(action.title)
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
