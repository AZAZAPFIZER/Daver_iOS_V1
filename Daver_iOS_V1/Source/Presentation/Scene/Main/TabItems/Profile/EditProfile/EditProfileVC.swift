//
//  EditProfileVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/27.
//

import UIKit
import Then
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

final class EditProfileVC: baseVC<EditProfileReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profileImage")
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.quaternaryLabel.cgColor
        $0.clipsToBounds = true
    }
    
    private let editProfileImageButton = UIButton().then {
        $0.setTitle("프로필 사진 변경", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.backgroundColor = .systemBlue
        $0.titleLabel?.textColor = .white
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(didTabeditProfileImageButton), for: .touchUpInside)
    }
    
    private let editNameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    }
    
    private let editNameTextField = UITextField().then {
        $0.placeholder = "홍길동"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.quaternaryLabel.cgColor
        $0.layer.cornerRadius = 10
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.leftSpace(20)
        $0.rightSpace(20)
    }
    
    private let editIntroduceLabel = UILabel().then {
        $0.text = "소개"
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    }
    
    private let editIntroduceTextField = UITextView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.quaternaryLabel.cgColor
        $0.layer.cornerRadius = 10
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        
    }
    
    private let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc private func done() {
        Observable.just(.done)
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    private lazy var imagePickerController = UIImagePickerController().then  {
        $0.sourceType = .photoLibrary
        $0.allowsEditing = true
        $0.delegate = self
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
                flex.addItem(profileImageView)
                    .marginTop(30)
                    .size(80)
                
                flex.addItem(editProfileImageButton)
                    .marginTop(10)
                    .marginHorizontal(50)
                    .height(30)
                    .width(33%)
                
                flex.addItem(editNameLabel)
                    .width(80%)
                    .marginTop(10)
                
                flex.addItem(editNameTextField)
                    .marginTop(10)
                    .marginHorizontal(50)
                    .height(30)
                    .width(80%)
                
                flex.addItem(editIntroduceLabel)
                    .width(80%)
                    .marginTop(20)
                
                flex.addItem(editIntroduceTextField)
                    .width(80%)
                    .marginTop(10)
                    .marginHorizontal(50)
                    .height(100)
                
                flex.addItem(doneButton)
                    .marginTop(30)
                    .marginHorizontal(50)
                    .height(30)
                    .width(18%)
            }
    }
    
    override func configureVC() {
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: EditProfileReactor) {
        editNameTextField.rx.text
            .orEmpty
            .map(Reactor.Action.name)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        editIntroduceTextField.rx.text
            .orEmpty
            .map(Reactor.Action.intro)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    
    
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

private extension EditProfileVC {
    @objc func didTabeditProfileImageButton() {
        present(imagePickerController, animated: true)
    }
}
