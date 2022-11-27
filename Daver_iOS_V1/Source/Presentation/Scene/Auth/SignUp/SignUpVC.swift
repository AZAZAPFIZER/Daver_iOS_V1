//
//  SignUpVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/18.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

final class SignUpVC: baseVC<SignUpReactor> {
    // MARK: - Metric
    enum Metric {
        static let primary = UIColor(named: "Daver_Primary_Purple")!
        static let gray = UIColor(named: "Daver_Gray")!
    }
    // MARK: - Properties
    private let rootContainer = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let bottomContainer = UIView()
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let testView = UIView().then {
        $0.backgroundColor = .red
    }
    
    private let nameTextField = SignInTextField(placeholder: "이름").then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    private let idTextField = SignInTextField(placeholder: "아이디").then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    private let pwTextField = SignInTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }
    
    private let pwVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash.fill")?.tintColor(Metric.gray), for: .normal)
    }
    
    private let pwCheckTextField = SignInTextField(placeholder: "비밀번호 확인").then {
        $0.isSecureTextEntry = true
    }
    
    private let pwCheckVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash.fill")?.tintColor(Metric.gray), for: .normal)
    }
    
    private let adressTextField = SignInTextField(placeholder: "도로명 주소를 입력해 주세요").then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    private let signUpButton = SignInButton(
        text: "회원가입",
        foregroundColor: .systemBackground,
        backgroundColor: Metric.primary,
        BColor: .clear
    )
    
    private let divisionLine = DivisionLine()
    
    private let signInLabel = UILabel().then {
        $0.text = "이미 회원이신가요?  "
        $0.textColor = Metric.gray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private let signInButton = UIButton().then {
        $0.setTitle("로그인 하기", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(Metric.primary, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - UI
    override func configureVC() {
        nameTextField.delegate = self
        idTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
    }
    
    override func addView() {
        scrollView.addSubViews(rootContainer, bottomContainer)
        view.addSubViews(scrollView)
    }
    
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        rootContainer.pin.width(100%)
        rootContainer.flex.layout(mode: .adjustHeight)
        bottomContainer.pin.width(100%)
        bottomContainer.flex.layout()
        scrollView.contentSize = rootContainer.frame.size
    }
    
    override func setLayout() {
        rootContainer.flex
            .marginBottom(100)
            .define { flex in
                // MARK: - Logo
                flex.addItem()
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(logoImageView)
                            .width(112)
                            .aspectRatio(0.571)
                    }
                
                // MARK: - Name
                flex.addItem()
                    .marginTop(35)
                    .marginLeft(36)
                    .marginRight(36)
                    .define { flex in
                        flex.addItem(nameTextField)
                            .width(100%)
                            .height(52)
                    }
                
                // MARK: - Id
                flex.addItem()
                    .marginTop(25)
                    .marginLeft(36)
                    .marginRight(36)
                    .define { flex in
                        flex.addItem(idTextField)
                            .width(100%)
                            .height(52)
                    }
                
                // MARK: - Pw
                flex.addItem()
                    .marginTop(25)
                    .marginLeft(36)
                    .marginRight(36)
                    .define { flex in
                        flex.addItem(pwTextField)
                            .width(100%)
                            .height(52)
                            .direction(.rowReverse)
                            .define { flex in
                                flex.addItem(pwVisibleButton)
                                    .width(24)
                                    .height(24)
                                    .marginLeft(14)
                                    .marginRight(14)
                                    .marginVertical(12)
                            }
                    }
                
                // MARK: - PwCheck
                flex.addItem()
                    .marginTop(25)
                    .marginLeft(36)
                    .marginRight(36)
                    .define { flex in
                        flex.addItem(pwCheckTextField)
                            .width(100%)
                            .height(52)
                            .direction(.rowReverse)
                            .define { flex in
                                flex.addItem(pwCheckVisibleButton)
                                    .width(24)
                                    .height(24)
                                    .marginLeft(14)
                                    .marginRight(14)
                                    .marginVertical(12)
                            }
                    }
                
                flex.addItem()
                    .marginTop(25)
                    .marginLeft(36)
                    .marginRight(36)
                    .define { flex in
                        flex.addItem(adressTextField)
                            .width(100%)
                            .height(52)
                    }
                
                // MARK: - SignUpButton
                flex.addItem()
                    .marginTop(50)
                    .define { flex in
                        flex.addItem(signUpButton)
                            .height(52)
                            .margin(36)
                    }
                
                flex.addItem(divisionLine)
                
                flex.addItem()
                    .direction(.row)
                    .marginTop(22)
                    .justifyContent(.center)
                    .define { flex in
                        flex.addItem(signInLabel)
                        flex.addItem(signInButton)
                    }
            }
        
        
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SignUpReactor) {
        signUpButton.rx.tap
            .map { Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateName)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateId)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updatePw)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwVisibleButton.rx.tap
            .map { Reactor.Action.pwVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwCheckTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updatePwCheck)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwCheckVisibleButton.rx.tap
            .map { Reactor.Action.pwCheckVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        adressTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateAddress)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .map { Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .map { Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: SignUpReactor) {
        let shareState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        shareState
            .map(\.pwVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.pwTextField.isSecureTextEntry = !visible
                owner.pwVisibleButton.setImage(UIImage(
                    systemName: visible ? "eye.fill" : "eye.slash.fill")?
                    .tintColor(visible ? Metric.primary : Metric.gray)
                                               , for: .normal)
            }
            .disposed(by: disposeBag)
        
        shareState
            .map(\.pwCheckVisible)
            .withUnretained(self)
            .bind { owner, visible in
                owner.pwCheckTextField.isSecureTextEntry = !visible
                owner.pwCheckVisibleButton.setImage(UIImage(
                    systemName: visible ? "eye.fill" : "eye.slash.fill")?
                    .tintColor(visible ? Metric.primary : Metric.gray)
                                               , for: .normal)
            }
            .disposed(by: disposeBag)
        
        shareState
            .map(\.valid)
            .withUnretained(self)
            .bind { owner, item in
                owner.signUpButton.isEnabled = item
                owner.signUpButton.backgroundColor = item ? Metric.primary : Metric.gray
            }
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Metric.primary.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Metric.gray.cgColor
    }
}
