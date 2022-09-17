//
//  OnBoardingVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import Then
import PinLayout
import FlexLayout

final class OnBoardingVC: baseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let mainContainer = UIView()
    private let logoImageView = UIImageView().then {
        //$0.image =
        $0.contentMode = .scaleAspectFit
    }
    private let signUpButton = OnBoardingButton(text: "회원가입", foregroundColor: .label, backgroundColor: .clear)
    private let signInButton = OnBoardingButton(text: "로그인", foregroundColor: .white, backgroundColor: UIColor(named: "MainColor")!)
    // MARK: - UI
    override func addView() {
        view.addSubViews(mainContainer, logoImageView)
    }
    override func setLayoutSubViews() {
        logoImageView.pin.top(39%).horizontally(25%).bottom(55%)
        mainContainer.pin.bottom(view.pin.safeArea.bottom + 10).horizontally(16).height(108)
        
        mainContainer.flex.direction(.columnReverse).define { flex in
            flex.addItem(signInButton).width(100%).height(50)
            flex.addItem(signUpButton).width(100%).height(50).marginBottom(8)
        }
        mainContainer.flex.layout()
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
    override func bindView(reactor: OnBoardingReactor) {
        signUpButton.rx.tap
            .map { Reactor.Action.signUpButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        signInButton.rx.tap
            .map { Reactor.Action.signInButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
