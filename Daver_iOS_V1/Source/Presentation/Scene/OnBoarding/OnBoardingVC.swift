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
    private let rootContainer = UIView()
    private let topContainer = UIView()
    private let logoImageView = UIImageView().then {
        //$0.image =
        $0.contentMode = .scaleAspectFit
    }
    
    private let signUpButton = OnBoardingButton(
        text: "회원가입",
        foregroundColor: .label,
        backgroundColor: .clear,
        BColor: .black
    )
    
    private let signInButton = OnBoardingButton(
        text: "로그인",
        foregroundColor: .white,
        backgroundColor: UIColor(named: "MainColor")!,
        BColor: .clear
    )
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(topContainer, rootContainer)
    }

    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
        topContainer.pin.all(view.pin.safeArea)
        topContainer.flex.layout()
    }

    override func setLayout() {
        topContainer.flex
            .alignItems(.center)
            .marginTop(100)
            .define { flex in
                flex.addItem(logoImageView)
                    .width(180)
                    .aspectRatio(2.857)
            }
        rootContainer.flex
            .justifyContent(.end)
            .marginBottom(20)
            .define { flex in
                flex.addItem()
                    .marginLeft(30)
                    .marginRight(30)
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(signInButton)
                            .width(100%)
                            .height(50)
                            .marginBottom(10)
                        flex.addItem(signUpButton)
                            .width(100%)
                            .height(50)
                    }
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
