//
//  AlertCell.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit

class AlertCell: UITableViewCell {

    static let identifier = "alertCell"

    
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "푸시 알림"
        label.font = .sfPro18Pt2
        label.textColor = .white1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(label)
        contentView.backgroundColor = .greyishDeepBrown
    }
    
    private func autoLayout() {
        //label.backgroundColor = .lightGray
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.top.equalTo(5)
            $0.width.equalTo(48)
            $0.trailing.equalTo(-5)
        }
    }

}
