//
//  ArtHeaderView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/14.
//

import UIKit

// 간단 작품 정보 뷰
class ArtHeaderView: BaseView {
    
    // MARK: - Properties
    
    public var data: ArtHeaderViewData? {
        didSet {
            updateUI()
        }
    }
    
    private weak var stackView: UIStackView!
    private weak var leftView: UIView!
    private weak var rightView: UIView!
    
    private weak var thumbnailImageView: UIImageView!
    private weak var profileImageView: UIImageView!
    private weak var nicknameLabel: UILabel!
    private weak var goArtistHomeButton: UIButton!
    private weak var titleLabel: UILabel!
    private weak var priceLabel: UILabel!
    private weak var simpleDescriptionLabel: UILabel!
    private weak var fileTypeStackView: UIStackView! // file type uiview를 넣을 스택뷰
    private weak var fileTypeButton1: UIButton!
    private weak var fileTypeButton2: UIButton!
    private weak var fileTypeButton3: UIButton!
    
    private weak var watermarkLabel: UILabel!
    public weak var soldoutView: SoldoutView!
    
    // MARK: - Functions
    
    private func updateUI() {
        if let data = self.data {
            thumbnailImageView.loadImage(url: data.artImage)
            let thumbnailImage = DynamicImage(width: data.width, height: data.height)
            let height = DeviceUtils.calculateImageHeight(sourceImage: thumbnailImage, scaledToWidth: DeviceUtils.width)
            thumbnailImageView.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            
            soldoutView.isHidden = !data.sales ? true: false
            
            titleLabel.text = data.title
            priceLabel.text = "\(data.price)"
            simpleDescriptionLabel.text = data.simpleDescription
            
            switch data.filetype.count {
            case 1:
                fileTypeButton1.setTitle(data.filetype.first!, for: .normal)
                fileTypeButton2.isHidden = true
                fileTypeButton3.isHidden = true
            case 2:
                fileTypeButton1.setTitle(data.filetype.first!, for: .normal)
                fileTypeButton2.setTitle(data.filetype.last!, for: .normal)
                fileTypeButton3.isHidden = true
            default:
                fileTypeButton1.setTitle(data.filetype.first!, for: .normal)
                fileTypeButton2.setTitle(data.filetype[1], for: .normal)
            }
        }
    }
    
    override func setLayout() {
        self.backgroundColor = .mediumBlack
        
        thumbnailImageView = UIImageView().then {
            $0.image = UIImage(named: "artDummy2")
            $0.contentMode = .scaleAspectFit
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                let height = UIImage(named: "artDummy2")?.scaledHeight(scaledWidth: DeviceUtils.width)
                $0.height.equalTo(height!)
            }
        }
        
        stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .fill
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(thumbnailImageView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        }
        
        leftView = UIView().then {
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.width.equalTo(200)
            }
        }
        
        rightView = UIView().then {
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.width.equalTo(DeviceUtils.width - 40 - leftView.frame.width)
            }
        }
        
        profileImageView = UIImageView().then {
            $0.backgroundColor = .green
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 43 * 0.5
            leftView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(14)
                $0.leading.equalToSuperview()
                $0.size.equalTo(CGSize(width: 43, height: 43))
            }
        }

        nicknameLabel = UILabel().then {
            $0.text = "일러스트레이터 이름"
            $0.textColor = .white
            $0.font = .sfPro14Pt
            leftView.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(profileImageView.snp.trailing).offset(9)
                $0.centerY.equalTo(profileImageView.snp.centerY)
            }
        }

        goArtistHomeButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .semibold), forImageIn: .normal)
            $0.tintColor = .white
            leftView.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(nicknameLabel.snp.trailing).offset(6)
                $0.centerY.equalTo(nicknameLabel.snp.centerY)
                $0.height.width.equalTo(10)
            }
        }

        titleLabel = UILabel().then {
            $0.text = "안녕하세요 반갑습니다 하하하~!~!!~~!~!"
            $0.textColor = .white
            $0.font = .sfPro18Pt2
            $0.numberOfLines = 2
            leftView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(profileImageView.snp.bottom).offset(21)
                $0.leading.equalToSuperview().inset(4)
                $0.width.equalToSuperview()
            }
        }

        // 단위 레이블
        let wonLabel = UILabel().then {
            $0.text = "원"
            $0.textColor = .white
            $0.font = .sfPro17Pt3
            rightView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(72)
                $0.trailing.equalToSuperview()
            }
        }

        priceLabel = UILabel().then {
            $0.text = "100,000"
            $0.textColor = .white
            $0.font = .sfPro25Pt2
            $0.sizeToFit()
            rightView.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(wonLabel.snp.leading).offset(-5)
                $0.bottom.equalTo(wonLabel.snp.bottom).offset(3)
            }
        }
        
        simpleDescriptionLabel = UILabel().then {
            $0.text = "짧은 작품 소개글\n최대 50자"
            $0.textColor = .white
            $0.font = .sfPro11Pt
            $0.numberOfLines = 2
            leftView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(20)
                $0.leading.equalTo(titleLabel.snp.leading)
                $0.width.equalToSuperview()
            }
        }

        fileTypeStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 6
            $0.distribution = .fill
            rightView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(priceLabel.snp.bottom).offset(14)
                $0.trailing.equalToSuperview()
                $0.bottom.equalToSuperview().inset(30).priority(.low)
                $0.width.equalTo(64)
            }
        }

        fileTypeButton1 = UIButton().then {
            $0.setTitle("JPG", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro11Pt6
            $0.backgroundColor = .lavenderPink
            $0.layer.cornerRadius = 3
            fileTypeStackView.addArrangedSubview($0)

            $0.snp.makeConstraints {
                $0.height.equalTo(23)
            }
        }

        fileTypeButton2 = UIButton().then {
            $0.setTitle("PNG", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro11Pt6
            $0.backgroundColor = .butterscotch
            $0.layer.cornerRadius = 3
            fileTypeStackView.addArrangedSubview($0)

            $0.snp.makeConstraints {
                $0.height.equalTo(23)
            }
        }

        fileTypeButton3 = UIButton().then {
            $0.setTitle("그외 3가지", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro11Pt6
            $0.backgroundColor = .tea
            $0.layer.cornerRadius = 3
            fileTypeStackView.addArrangedSubview($0)

            $0.snp.makeConstraints {
                $0.height.equalTo(23)
            }
        }

        watermarkLabel = UILabel().then {
            $0.text = "여기그림"
            $0.textColor = .white.withAlphaComponent(0.7)
            $0.font = .gmarketSans22Pt
            self.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(thumbnailImageView.snp.trailing).offset(-18)
                $0.bottom.equalTo(thumbnailImageView.snp.bottom).offset(-12)
            }
        }
        
        soldoutView = SoldoutView().then {
            $0.isHidden = true
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(thumbnailImageView.snp.edges)
            }
        }
    }
}
