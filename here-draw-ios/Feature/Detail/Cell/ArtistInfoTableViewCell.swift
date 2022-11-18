//
//  ArtistInfoTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

class ArtistInfoTableViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var isMyArt: Bool = false {
        didSet {
            if isMyArt {
                followButton.backgroundColor = .greyishLightBrown
                followButton.isEnabled = false
                messageButton.backgroundColor = .greyishLightBrown
                messageButton.isEnabled = false
            }
        }
    }
    var isFollowing: Bool = false {
        didSet {
            followButton.isSelected = isFollowing
            followButton.backgroundColor = isFollowing ? .greyishLightBrown: .pastelYellow
        }
    }
    
    private weak var profileImageView: UIImageView!
    private weak var nicknameLabel: UILabel!
    private weak var goArtistHomeButton: UIButton!
    private weak var followerCountLabel: UILabel!
    private weak var likeCountLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    private weak var followButton: UIButton!
    private weak var messageButton: UIButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data: ArtistInfoData?) {
        guard let data = data else  { return }
        contentView.backgroundColor = .mediumBlack
        
        profileImageView = UIImageView().then {
            $0.image = UIImage(named: "profile")
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 43 * 0.5
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(30)
                $0.leading.equalToSuperview().inset(19)
                $0.size.equalTo(CGSize(width: 64, height: 64))
            }
        }
        
        if let profileImage = data.profileImg {
            profileImageView.loadImage(url: profileImage)
        }
        
        nicknameLabel = UILabel().then {
            $0.text = data.nickname
            $0.textColor = .white
            $0.font = .sfPro14Pt4
            contentView.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
                $0.top.equalTo(profileImageView.snp.top)
            }
        }
        
        goArtistHomeButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .semibold), forImageIn: .normal)
            $0.tintColor = .white
            contentView.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(nicknameLabel.snp.trailing).offset(6)
                $0.centerY.equalTo(nicknameLabel.snp.centerY)
                $0.height.width.equalTo(10)
            }
        }
        
        let followerLabel = UILabel().then {
            $0.text = "팔로워"
            $0.textColor = .white
            $0.font = .sfPro11Pt
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(nicknameLabel.snp.bottom).offset(14)
                $0.leading.equalTo(nicknameLabel.snp.leading)
            }
        }
        
        followerCountLabel = UILabel().then {
            $0.text = "\(data.followerCnt)"
            $0.textColor = .white
            $0.font = .sfPro14Pt4
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(followerLabel.snp.bottom).offset(3)
                $0.centerX.equalTo(followerLabel.snp.centerX)
            }
        }
        
        let likesLabel = UILabel().then {
            $0.text = "작품 찜"
            $0.textColor = .white
            $0.font = .sfPro11Pt
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(followerLabel.snp.top)
                $0.leading.equalTo(followerLabel.snp.trailing).offset(38)
            }
        }
        
        likeCountLabel = UILabel().then {
            $0.text = "\(data.likeCnt)"
            $0.textColor = .white
            $0.font = .sfPro14Pt4
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(followerCountLabel.snp.top)
                $0.centerX.equalTo(likesLabel.snp.centerX)
            }
        }
        
        descriptionLabel = UILabel().then {
            $0.text = data.description ?? ""
            $0.textColor = .white
            $0.font = .sfPro11Pt
            $0.numberOfLines = 10
            $0.sizeToFit()
            contentView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(profileImageView.snp.bottom).offset(30)
                $0.leading.equalTo(profileImageView.snp.leading)
                $0.trailing.equalToSuperview().inset(60)
                if data.description == nil {
                    $0.height.equalTo(0)
                }
            }
        }
        
        followButton = UIButton().then {
            $0.setTitle("팔로우", for: .normal)
            $0.setTitle("팔로잉", for: .selected)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro14Pt4
            $0.backgroundColor = .pastelYellow
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(29)
                $0.leading.equalToSuperview().inset(20)
                $0.width.equalToSuperview().multipliedBy(0.44)
                $0.height.equalToSuperview().multipliedBy(0.15)
                $0.bottom.equalToSuperview().inset(30).priority(.medium)
            }
        }
        
        messageButton = UIButton().then {
            $0.setTitle("메시지", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .sfPro14Pt4
            $0.backgroundColor = .tea
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(messageButtonTapped(_:)), for: .touchUpInside)
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(followButton.snp.top)
                $0.trailing.equalToSuperview().inset(20)
                $0.width.equalTo(followButton.snp.width)
                $0.height.equalTo(followButton.snp.height)
                $0.bottom.equalToSuperview().inset(30).priority(.medium)
            }
        }
        
        isMyArt = data.myArt
        isFollowing = data.isFollowing
    }
    
    @objc
    func followButtonTapped(_ sender: UIButton) {
        isFollowing.toggle()
        // TODO: 팔로우 api 호출
    }
    
    @objc
    func messageButtonTapped(_ sender: UIButton) {
        // TODO: 작가 메시지 연결
        print("Go to message")
    }

}
