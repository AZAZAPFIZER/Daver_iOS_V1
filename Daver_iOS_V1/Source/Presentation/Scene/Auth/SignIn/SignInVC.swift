//
//  OnBoardingVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import Then
import PinLayout
import ReactorKit
import RxSwift
import RxCocoa
import FlexLayout

final class SignInVC: baseVC<SignInReactor> {
    // MARK: - Metric
    enum Metric {
        static var primary = UIColor(named: "Daver_Primary_Purple")!
        static var gray = UIColor(named: "Daver_Gray")!
    }
    // MARK: - Properties
    private let rootContainer = UIView()
    private let bottomContainer = UIView()
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
        $0.contentMode = .scaleAspectFit
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
    
    private let signInButton = SignInButton(
        text: "로그인",
        foregroundColor: .white,
        backgroundColor: Metric.primary,
        BColor: .clear
    )
    
    private let forgotPwLabel = UILabel().then {
        $0.text = "비밀번호를 잊으셨나요?  "
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = Metric.gray
    }
    
    private let forgotPwButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(Metric.primary, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private let divisionLine = DivisionLine()
    
    private let signUpLabel = UILabel().then {
        $0.text = "회원이 아니신가요?  "
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = Metric.gray
    }
    
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입 하기", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(Metric.primary, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - UI
    override func configureVC() {
        idTextField.delegate = self
        pwTextField.delegate = self
    }
    
    override func addView() {
        view.addSubViews(bottomContainer, rootContainer)
    }
    
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
        bottomContainer.pin.all(view.pin.safeArea)
        bottomContainer.flex.layout()
    }
    
    override func setLayout() {
        rootContainer.flex
            .marginTop(30)
            .marginBottom(50)
            .define { flex in
                // MARK: - Logo
                flex.addItem()
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(logoImageView)
                            .width(105)
                            .aspectRatio(0.571)
                    }
                // MARK: - Id
                flex.addItem()
                    .marginTop(50)
                    .marginLeft(28)
                    .marginRight(28)
                    .define { flex in
                        flex.addItem(idTextField)
                            .width(100%)
                            .height(52)
                            .margin(8)
                            
                    }
                // MARK: - Pw
                flex.addItem()
                    .marginTop(14)
                    .marginLeft(28)
                    .marginRight(28)
                    .define { flex in
                        flex.addItem(pwTextField)
                            .marginVertical(12)
                            .width(100%)
                            .height(52)
                            .margin(8)
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
                flex.addItem()
                    .define { flex in
                        flex.addItem(signInButton)
                            .height(52)
                            .margin(36)
                    }
                flex.addItem()
                    .justifyContent(.center)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(forgotPwLabel)
                        flex.addItem(forgotPwButton)
                    }
            }
        bottomContainer.flex
            .direction(.columnReverse)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .marginTop(22)
                    .justifyContent(.center)
                    .define { flex in
                        flex.addItem(signUpLabel)
                        flex.addItem(signUpButton)
                    }
                flex.addItem(divisionLine)
        }
    }
    
    override func configureNavigation() {
        self.navigationItem.configBack()
    }
    
    override func darkConfigure() {
        /** TodoList **/
        /*
         1. 다크모드
         */
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SignInReactor) {
        signUpButton.rx.tap
            .map { Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .map { Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        forgotPwButton.rx.tap
            .map { Reactor.Action.forgotPwButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwVisibleButton.rx.tap
            .map { Reactor.Action.pwVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idTextField.rx.text
            .orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateId)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text
            .orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updatePw)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: SignInReactor) {
        let shareState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
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
            .map(\.valid)
            .withUnretained(self)
            .bind { owner, item in
                owner.signInButton.isEnabled = item
                owner.signInButton.backgroundColor = item ? Metric.primary : Metric.gray
            }
            .disposed(by: disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Metric.primary.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Metric.gray.cgColor
    }
}
