//
//  ArtInfoTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

class ArtInfoTableViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var copyrights = ["개인 사용", "상업적 이용", "2차가공 허용", "재배포 허용"]   // dummy
    
    private weak var copyrightStackView: UIStackView!
    private weak var descriptionLabel: UILabel!
    private weak var foldButton: ButtonWithImageOnTheRight!

    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: fetch 성공하면 사용할 것.
    func addCopyright(text: String) {
        let copyright = UIButton().then {
            $0.setTitle(text, for: .normal)
            $0.setTitleColor(.pastelYellow, for: .normal)
            $0.titleLabel?.font = .sfPro14Pt4
            $0.titleLabel?.sizeToFit()
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.pastelYellow.cgColor
            $0.layer.cornerRadius = 16
            copyrightStackView.addArrangedSubview($0)
        }
        copyright.snp.makeConstraints() {
            let width = copyright.titleLabelWidth()
            $0.width.equalTo(width + 20)    // inset: 10
        }
    }
    
    func updateUI() {
        contentView.backgroundColor = .mediumBlack
        
        let warningLabel = UILabel().then {
            $0.text = "! CAUTION !"
            $0.font = .systemFont(ofSize: 23, weight: .medium)
            $0.textColor = .lavenderPink
            $0.textAlignment = .center
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(30)
                
            }
        }
        
        let subLabel = UILabel().then {
            $0.text = "작가가 허용하지 않은 라이센스까지 무단 활용할 시 법적 처벌을 받을 수 있습니다."
            $0.font = .sfPro11Pt6
            $0.textColor = .lavenderPink
            $0.textAlignment = .center
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(warningLabel.snp.bottom).offset(15)
            }
        }
        
        copyrightStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 6
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(subLabel.snp.bottom).offset(20)
//                $0.leading.trailing.equalToSuperview().inset(28)
                $0.height.equalTo(29)
                $0.centerX.equalToSuperview()
            }
        }
        
        copyrights.forEach {
            addCopyright(text: $0)
        }
        
        descriptionLabel = UILabel().then {
            $0.text = """
                    💐
                    
                    안녕하세요!
                    이 작품은 영지 X 래원 콜라보 음원,
                    ‘ANEMONE’ 노래 앨범커버 디자인입니다.
                    아네모네의 꽃말은 사랑의 괴로움,
                    고마웠던 사랑 등 슬픈 꽃말을 갖고있어요.
                    커버 속 여자는 래퍼 이영지이며 그녀가 짝사랑했던 래퍼
                    래원을 텅빈 가슴 속에 넣어 텅 빈사랑을 표현해내었습니다.
                    색감은 아네모네의 보라색 색감과 어우러지도록 퍼플-핑크계열의 색감을 활용했으며, 작품 속 영지가 입고 있는 옷은 작품 뮤비 속 옷과 같답니다.
                    """
            $0.font = .sfPro16Pt
            $0.textColor = .white
            $0.textAlignment = .center
            $0.numberOfLines = 100
            $0.sizeToFit()
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(copyrightStackView.snp.bottom).offset(30)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(400)
            }
        }
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(descriptionLabel.frame.height)
        }
        
        foldButton = ButtonWithImageOnTheRight().then {
            $0.setTitle("작품 정보 더보기", for: .normal)
            $0.setTitle("작품 정보 접기", for: .selected)
            $0.titleLabel?.font = .sfPro16Pt
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            
            $0.backgroundColor = .warmBlue
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.setImage(UIImage(systemName: "chevron.up"), for: .selected)
            $0.imageView?.tintColor = .white
            $0.setPreferredSymbolConfiguration(.init(pointSize: 12, weight: .bold), forImageIn: .normal)
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(500)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(58)
                $0.bottom.equalToSuperview().inset(30).priority(.low)
            }
        }
    }

}
