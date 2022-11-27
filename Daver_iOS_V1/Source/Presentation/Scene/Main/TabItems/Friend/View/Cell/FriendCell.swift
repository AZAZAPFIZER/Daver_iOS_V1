//
//  FriendCell.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/26.
//

import UIKit
import PinLayout
import FlexLayout
import Then
import RxSwift
import Kingfisher

final class FriendCell: baseTableViewCell<FriendList> {
    private let rootContainer = UIView()
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    private let nameLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    private let addressLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all()
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex
            .height(100)
            .alignItems(.center)
            .direction(.row)
            .define { flex in
                flex.addItem(profileImageView)
                    .margin(16)
                    .height(50)
                    .width(50)
                
                flex.addItem()
                    .define { flex in
                        flex.addItem(nameLabel)
                        flex.addItem(addressLabel)
                    }
            }
    }
    
    override func bind(_ model: FriendList) {
        nameLabel.text = model.name
        nameLabel.flex.markDirty()
        
        addressLabel.text = model.address
        addressLabel.flex.markDirty()
        
        profileImageView.kf.setImage(with: URL(string: "profileImageUrl"), placeholder: UIImage(named: "profileImage"))
    }
}
