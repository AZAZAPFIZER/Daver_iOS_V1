//
//  ReqFriendVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/27.
//

import UIKit
import Then
import FlexLayout
import PinLayout

final class ReqFriendVC: baseVC<ReqFriendReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    
    private let view1 = UIView()
    private let profileImageView1 = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.image = UIImage(named: "카카")
        $0.clipsToBounds = true
    }
    private let nameLabel1 = UILabel().then {
        $0.text = "카카오"
    }
    private let addressLabel1 = UILabel().then {
        $0.text = "제주특별자치도 제주시 첨단로 242"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let yesButton1 = UIButton().then {
        $0.setTitle("수락", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemGreen
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(yesTap), for: .touchUpInside)
    }
    
    private let noButton1 = UIButton().then {
        $0.setTitle("거절", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemRed
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
    }
    
    @objc private func yesTap() {
        profileImageView1.image = .none
        nameLabel1.text = ""
        addressLabel1.text = ""
        yesButton1.setTitle("", for: .normal)
        yesButton1.backgroundColor = .white
        noButton1.setTitle("", for: .normal)
        noButton1.backgroundColor = .white
        
        view1.flex.isIncludedInLayout = false
        rootContainer.flex.layout()
        
        let alert = UIAlertController(title: "알림", message: "카카오 님의 친구요청을 수락하였습니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    private let view2 = UIView()
    private let profileImageView2 = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
        $0.image = UIImage(named: "페소")
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    private let nameLabel2 = UILabel().then {
        $0.text = "배준철"
    }
    private let addressLabel2 = UILabel().then {
        $0.text = "대구 동구 동대구로 461, 10층 1004호"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let yesButton2 = UIButton().then {
        $0.setTitle("수락", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemGreen
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
    }
    private let noButton2 = UIButton().then {
        $0.setTitle("거절", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemRed
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(noTap), for: .touchUpInside)
    }
    
    @objc private func noTap() {
        profileImageView2.image = .none
        nameLabel2.text = ""
        addressLabel2.text = ""
        yesButton2.setTitle("", for: .normal)
        yesButton2.backgroundColor = .white
        noButton2.setTitle("", for: .normal)
        noButton2.backgroundColor = .white
        
        view2.flex.isIncludedInLayout = false
        rootContainer.flex.layout()
        
        let alert = UIAlertController(title: "알림", message: "배준철 님의 친구요청을 거절하였습니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    private let profileImageView3 = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
        $0.image = UIImage(named: "월스")
    }
    private let nameLabel3 = UILabel().then {
        $0.text = "강철희"
    }
    private let addressLabel3 = UILabel().then {
        $0.text = "대구광역시 수성구 유니버시아드로"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    private let yesButton3 = UIButton().then {
        $0.setTitle("수락", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemGreen
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
    }
    private let noButton3 = UIButton().then {
        $0.setTitle("거절", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.backgroundColor = .systemRed
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 3
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    
    override func setLayout() {
        rootContainer.flex
            .alignItems(.center)
            .define { flex in
                flex.addItem(view1)
                    .markDirty()
                    .height(100)
                    .width(100%)
                    .alignItems(.center)
                    .justifyContent(.spaceBetween)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(profileImageView1)
                            .margin(16)
                            .height(50)
                            .width(50)
                        
                        flex.addItem()
                            .define { flex in
                                flex.addItem(nameLabel1)
                                flex.addItem(addressLabel1)
                            }
                        
                        flex.addItem()
                            .justifyContent(.spaceBetween)
                            .marginRight(16)
                            .define { flex in
                                flex.addItem(yesButton1)
                                    .height(20)
                                    .width(60)
                                flex.addItem(noButton1)
                                    .marginTop(3)
                                    .height(20)
                                    .width(60)
                            }
                    }
                
                //                    flex.addItem(divisionLine1)
                //                        .width(90%)
                
                flex.addItem(view2)
                    .height(100)
                    .width(100%)
                    .alignItems(.center)
                    .justifyContent(.spaceBetween)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(profileImageView2)
                            .margin(16)
                            .height(50)
                            .width(50)
                        
                        flex.addItem()
                            .define { flex in
                                flex.addItem(nameLabel2)
                                flex.addItem(addressLabel2)
                            }
                        
                        flex.addItem()
                            .justifyContent(.spaceBetween)
                            .marginRight(16)
                            .define { flex in
                                flex.addItem(yesButton2)
                                    .height(20)
                                    .width(60)
                                flex.addItem(noButton2)
                                    .marginTop(3)
                                    .height(20)
                                    .width(60)
                            }
                    }
                
                //                    flex.addItem(divisionLine2)
                //                        .width(90%)
                
                flex.addItem()
                    .height(100)
                    .width(100%)
                    .alignItems(.center)
                    .justifyContent(.spaceBetween)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(profileImageView3)
                            .margin(16)
                            .height(50)
                            .width(50)
                        
                        flex.addItem()
                            .define { flex in
                                flex.addItem(nameLabel3)
                                flex.addItem(addressLabel3)
                            }
                        
                        flex.addItem()
                            .justifyContent(.spaceBetween)
                            .marginRight(16)
                            .define { flex in
                                flex.addItem(yesButton3)
                                    .height(20)
                                    .width(60)
                                flex.addItem(noButton3)
                                    .marginTop(3)
                                    .height(20)
                                    .width(60)
                            }
                    }
            }
    }
}
