//
//  AgreementViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/09.
//

import UIKit

class AgreementViewController: BaseViewController {
    
    // MARK: - Properties
    
    var agreeTitle: String!
    
    private weak var titleLabel: UILabel!
    private weak var contentLabel: UILabel!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setNavigationBar()
    }
    
    // MARK: - Function
    
    func fetchTitle(str: String) {
        switch str {
        case "여기_그림 이용약관":
            agreeTitle = "서비스 약관 동의"
        case "개인정보 처리방침":
            agreeTitle = str
        default:
            return
        }
    }
    
    override func setNavigationBar() {
        let titleLabel = UILabel().then {
            $0.font = .sfPro18Pt2
            $0.text = agreeTitle
        }
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.titleView = titleLabel
    }
    
    override func setLayout() {
        let scrollView = UIScrollView().then {
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(15)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()
            }
        }
        
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 15
            $0.distribution = .fill
            scrollView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(15)
                $0.leading.trailing.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
        
        titleLabel = UILabel().then {
            $0.text = agreeTitle == "서비스 약관 동의" ? "여기_그림 서비스 이용약관": "여기_그림 개인정보 처리방침"
            $0.font = .sfPro18Pt2
            $0.textColor = .white1
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            }
        }
        
        contentLabel = UILabel().then {
            $0.text = agreeTitle == "서비스 약관 동의" ? AgreementContents.content1:AgreementContents.content2
            $0.font = .sfPro11Pt7
            $0.numberOfLines = 7000
            $0.textColor = .mediumGrey
            $0.sizeToFit()
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalTo(titleLabel.snp.leading)
                $0.trailing.equalToSuperview().inset(30)
                let height: CGFloat = agreeTitle == "서비스 약관 동의" ? 8050: 2250
                $0.height.equalTo(height)
            }
        }
    }
}
