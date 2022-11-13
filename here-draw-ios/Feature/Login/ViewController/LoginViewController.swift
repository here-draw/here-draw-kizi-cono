//
//  LoginViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/05.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKCommon

import Alamofire
import SnapKit
import Then

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    let viewModel = LoginViewModel()
    
    let onboardingImages = [
        UIImage(named: "onboarding1")!,
        UIImage(named: "onboarding2")!,
        UIImage(named: "onboarding3")!
    ]
    let contentTexts = [
        "세상 모든 그림 여기 한번에",
        "한눈에 그림을 보며 일상에 취향을 얹어보세요",
        "누구나 쉽게 작가가 될 수 있어요"
    ]
    
    private weak var onboardingCollectionView: UICollectionView!
    private weak var pageIndicator: UIPageControl!
    private weak var kakaoLoginButton: UIButton!
    private weak var appleLoginButton: UIButton!
    private weak var bottomSheetView: AgreeBottomSheetView!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    override func setLayout() {
        let subtitleLabel = UILabel().then {
            $0.text = "세상 모든 일러스트"
            $0.font = .gmarketSans21Pt
            $0.textColor = .lightGrey
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                let topInset = DeviceUtils.height * 0.163
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(topInset).priority(700)
                $0.centerX.equalToSuperview()
            }
        }
        
        let titleLabel = UILabel().then {
            $0.text = "여기_그림"
            $0.font = .gmarketSans40Pt
            $0.textColor = .pastelYellow
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(subtitleLabel.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
            }
        }
        
        onboardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
            $0.dataSource = self
            $0.delegate = self
            $0.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            $0.collectionViewLayout = flowLayout
            view.addSubview($0)

            $0.snp.makeConstraints {
                let topInset = DeviceUtils.height * 0.07
                $0.top.equalTo(titleLabel.snp.bottom).offset(topInset)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(315)
                $0.height.equalTo(202)
            }
        }
        
        pageIndicator = UIPageControl().then {
            $0.numberOfPages = onboardingImages.count
            $0.currentPage = 0
            $0.currentPageIndicatorTintColor = .pastelYellow
            $0.pageIndicatorTintColor = .greyishLightBrown
            $0.addTarget(self, action: #selector(pageChanged(_:)), for: .touchUpInside)
            view.addSubview($0)

            $0.snp.makeConstraints {
                let topOffset = DeviceUtils.height * 0.06
                
                $0.top.equalTo(onboardingCollectionView.snp.bottom).offset(topOffset)
                $0.centerX.equalToSuperview()
            }
        }
        
        kakaoLoginButton = UIButton().then {
            $0.layer.cornerRadius = 28
            $0.backgroundColor = .kakaoYellow
            $0.setTitle("카카오 로그인", for: .normal)
            $0.setTitleColor(.kakaoBlack, for: .normal)
            $0.titleLabel?.font = .sfPro20Pt
            
            $0.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
            view.addSubview($0)

            $0.snp.makeConstraints {
                let topOffset = DeviceUtils.height * 0.06
                $0.top.equalTo(pageIndicator.snp.bottom).offset(topOffset)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.82)
                $0.height.equalToSuperview().multipliedBy(0.063)
            }
        }
        
        // kakao logo
        let _ = UIImageView().then {
            $0.image = #imageLiteral(resourceName: "kakao")
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerY.equalTo(kakaoLoginButton)
                $0.leading.equalTo(kakaoLoginButton.snp.leading).offset(27.5)
                $0.width.equalTo(23)
            }
        }
        
        appleLoginButton = UIButton().then {
            $0.layer.cornerRadius = 28
            $0.backgroundColor = .white
            $0.setTitle("Apple로 로그인", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro20Pt
            
            $0.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(20)
                let bottomInset = DeviceUtils.height * 0.12
                $0.bottom.equalTo(view.safeAreaInsets).inset(bottomInset).priority(900)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(kakaoLoginButton.snp.width)
                $0.height.equalTo(kakaoLoginButton.snp.height)
            }
        }
        
        // apple logo
        let _ = UIImageView().then {
            $0.image = UIImage(named: "apple")
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerY.equalTo(appleLoginButton).offset(-2)
                $0.leading.equalTo(appleLoginButton.snp.leading).offset(27.5)
                $0.width.equalTo(23)
                $0.height.equalTo(28.2)
            }
        }

        let indexPath = IndexPath(item: pageIndicator.currentPage, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func presentBottomSheet() {
        bottomSheetView = AgreeBottomSheetView().then {
            $0.delegate = self
            $0.bottomSheetColor = .black1
            $0.bottomSheetShadowColor = UIColor.pastelYellow.cgColor
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    func handleSignIn() {
    }
    
    // MARK: objc func
    
    @objc
    func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc
    func kakaoLoginTapped() {
        viewModel.handleKakaoLogin { [weak self] hasNickname in
            if hasNickname {
                self?.gotoMain()
            } else {    // 최초 로그인
                self?.presentBottomSheet()
            }
        }
    }
    
    @objc
    func appleLoginTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Extension UICollectionViewDataSource

extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnboardingCollectionViewCell
        else { return UICollectionViewCell() }
        
        let index = indexPath.item
        cell.fetchItem(image: onboardingImages[index], text: contentTexts[index])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: - UIScrollViewDelegate

extension LoginViewController: UICollectionViewDelegate {
    // CollectionView가 옆으로 스크롤 될 때마다 pageControl 조정
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = onboardingCollectionView.frame.width
        let index = (Int(scrollView.contentOffset.x) / Int(width)) % onboardingImages.count
        pageIndicator.currentPage = index
    }
}

// MARK: - AgreeBottomSheetViewDelegate

extension LoginViewController: AgreeBottomSheetViewDelegate {
    func pushAgreementVC(title: String) {
        let vc = AgreementViewController()
        vc.fetchTitle(str: title)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushOnboardingVC() {
        let vc = OnboardingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Apple Login Extensions

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let accessToken = appleIDCredential.identityToken
            let tokenString = String(data: accessToken!, encoding: .utf8)
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("Token : \(tokenString ?? "")")
            
            viewModel.handleAppleLogin(token: tokenString!) { [weak self] hasNickname in
                if hasNickname {
                    self?.gotoMain()
                } else {
                    self?.presentBottomSheet()
                }
            }
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("--- login error")
    }
}
