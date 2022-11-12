//
//  AgreementTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/09.
//

import UIKit

import SnapKit
import Then

protocol AgreementTableViewCellDelegate: UIView {
    func checkTerms(didChecked: Bool, index: Int)
}

class AgreementTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: AgreementTableViewCellDelegate?
    
    public var didChecked: Bool = false {
        didSet {
            checkButton.isSelected = didChecked
        }
    }
    
    private var checkButton = UIButton()
    private weak var titleLabel: UILabel?
    private var moreButton = UIButton()
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        titleLabel?.text = ""
    }
    
    func fetchText(text: String) {
        titleLabel?.text = text
    }
    
    func controlMoreView(isOpened: Bool) {
        moreButton.isSelected = isOpened
    }
    
    func configureSectionUI() {
        contentView.backgroundColor = .black1
        
        checkButton.then {
            $0.setImage(UIImage(named: "check"), for: .normal)
            $0.setImage(UIImage(named: "check_active"), for: .selected)
            $0.setPreferredSymbolConfiguration(.init(pointSize: 16), forImageIn: .normal)
            $0.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }
        }
        
        titleLabel = UILabel().then {
            $0.font = .sfPro15Pt
            $0.textColor = .mediumGrey
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalTo(checkButton.snp.trailing).offset(6)
                $0.centerY.equalToSuperview()
            }
        }
        
        moreButton.then {
            $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            $0.setImage(UIImage(systemName: "chevron.up"), for: .selected)
            
            $0.setPreferredSymbolConfiguration(.init(pointSize: 12), forImageIn: .normal)
            $0.tintColor = .mediumGrey
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    func configureSectionDataUI() {
        contentView.backgroundColor = .black1
        
        if contentView.subviews.contains(checkButton) {
            checkButton.removeFromSuperview()
        }
        if contentView.subviews.contains(moreButton) {
            moreButton.removeFromSuperview()
        }
        
        titleLabel = UILabel().then {
            $0.font = .sfPro11Pt5
            $0.textColor = .mediumGrey
            
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
            $0.attributedText = underlineAttributedString
            
            $0.sizeToFit()
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalTo(42)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        didChecked.toggle()
        guard let text = titleLabel?.text else { return }
        let index = text == "여기_그림 이용약관 (필수)" ? 0: 1
        delegate?.checkTerms(didChecked: didChecked, index: index)
    }
}
