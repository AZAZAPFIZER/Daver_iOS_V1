//
//  ProfileVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import UIKit
import PinLayout
import FlexLayout
import Then
import ReactorKit

final class ProfileVC: baseVC<ProfileReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let scrollView = UIScrollView()
    private let profileContainer = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBackground
    }
    private let profileBackgroundColorView = UIView().then {
        $0.backgroundColor = UIColor(named: "Daver_Primary_Purple")!
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.image = UIImage(named: "profileImage")
        $0.backgroundColor = .gray
    }
    private let nameLabel = UILabel().then {
        $0.text = "김상은"
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .label
    }
    private let addressLabel = UILabel().then {
        $0.text = "대구시 수성구 노변로89 삼승월드타운 101동"
        $0.lineBreakMode = .byTruncatingMiddle
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .label
    }
    private let friendLabel = UILabel().then {
        $0.text = "친구"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .label
    }
    private let friendCountLabel = UILabel().then {
        $0.text = "2353"
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .label
    }
    private let followerLabel = UILabel().then {
        $0.text = "팔로워"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .label
    }
    private let followerCountLabel = UILabel().then {
        $0.text = "24"
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .label
    }
    private let followingLabel = UILabel().then {
        $0.text = "팔로잉"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .label
    }
    private let followingCountLabel = UILabel().then {
        $0.text = "532"
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .label
    }
    private let divisionLine = DivisionLine().then {
        $0.layer.cornerRadius = 1
    }
    private let introContaier = UIView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBackground
    }
    private let introLabel = UILabel().then {
        $0.text =
        """
        안녕하세요 저는 대구에 살고있는 고등학생 김상은입니당
        저의 취미는 축구이고, iOS 개발을 공부하고 있어요 ~ ㅎㅎ
        혹시 심심하시다면 저랑 친구해요!!
        """
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .label
    }
    private let linkTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .systemBlue
        $0.text = "https://github.com/SangAu124"
        $0.dataDetectorTypes = .link
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }
    
    private let testbutton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.backgroundColor = .systemBlue
        $0.titleLabel?.textColor = .white
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(didTabeditProfileImageButton), for: .touchUpInside)
    }
    
    
    private lazy var imagePickerController = UIImagePickerController().then  {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
    }
    
    private let moreOptionButton = UIBarButtonItem(image: .init(systemName: "ellipsis")?.tintColor(.label),
                                                   style: .plain,
                                                   target: nil,
                                                   action: nil)
    
    // MARK: - Menu Action
    private lazy var modifyProfileMenuAction = UIAction(title: "프로필 수정",image: UIImage(systemName: "pencil"),handler: { [weak self] _ in
        self?.reactor?.action.onNext(.modifyButtonDidTap)
    })
    private lazy var cancelMenuAction = UIAction(title: "취소", attributes: .destructive, handler: { _ in return })
    
    // MARK: - UI
    override func setUp() {
        if #available(iOS 14.0, *) {
            moreOptionButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [
                modifyProfileMenuAction,
                cancelMenuAction
            ])
        }
    }
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(rootContainer)
    }
    
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        rootContainer.pin.top().width(100%)
        
        rootContainer.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootContainer.frame.size
    }
    
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(profileContainer).define { flex in
                flex.addItem(profileBackgroundColorView)
                    .width(100%)
                    .height(99)
                flex.addItem()
                    .direction(.row)
                    .marginBottom(30)
                    .grow(1)
                    .define { flex in
                        flex.addItem()
                            .define { flex in
                            flex.addItem(profileImageView)
                                .marginLeft(10)
                                .size(80)
                                .marginTop(-22)
                            flex.addItem(testbutton)
                                .marginTop(30)
                                .marginLeft(30)
                                .height(20)
                                .width(40)
                            }
                        flex.addItem()
                            .marginHorizontal(20)
                            .grow(3)
                            .define { flex in
                                flex.addItem(nameLabel)
                                    .marginTop(8)
                                flex.addItem(addressLabel)
                                    .marginTop(8)
                                flex.addItem()
                                    .direction(.row)
//                                    .alignItems(.center)
                                    .justifyContent(.center)
                                    .marginTop(20)
                                    .define { flex in
                                        flex.addItem()
                                            .alignItems(.center)
                                            .define { flex in
                                                flex.addItem(friendLabel)
                                                flex.addItem(friendCountLabel)
                                                    .marginTop(5)
                                            }
                                    }
                            }
                    }
            }
            flex.addItem(divisionLine)
                .marginHorizontal(16)
            flex.addItem(introContaier)
                .marginTop(12)
                .define { flex in
                    flex.addItem(introLabel)
                        .marginHorizontal(14)
                        .marginTop(20)
                    flex.addItem(linkTextView)
                        .marginTop(8)
                        .marginHorizontal(14)
                        .marginBottom(20)
                }
        }
    }
    override func configureNavigation() {
        self.navigationItem.title = "프로필"
        self.navigationItem.setRightBarButtonItems([moreOptionButton], animated: true)
        self.navigationItem.configBack()
    }
    
    
    init(reactor: ProfileReactor?, info: Info) {
        super.init(reactor: reactor)
//        if info.name == "" {
//            nameLabel.text = "김상은"
//            introLabel.text =
//                    """
//                    안녕하세요 저는 대구에 살고있는 고등학생 김상은입니당
//                    저의 취미는 축구이고, iOS 개발을 공부하고 있어요 ~ ㅎㅎ
//                    혹시 심심하시다면 저랑 친구해요!!
//                    """
//        }
        
        nameLabel.text = info.name
        introLabel.text = info.intro
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage? = nil
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
        }
        
        self.profileImageView.image = selectImage
        
        picker.dismiss(animated: true)
    }
}

private extension ProfileVC {
    @objc func didTabeditProfileImageButton() {
        present(imagePickerController, animated: true)
    }
}
