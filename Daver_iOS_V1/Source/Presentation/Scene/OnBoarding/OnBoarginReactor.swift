//
//  OnBoarginReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import ReactorKit
import RxRelay
import RxFlow

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case signUpButtonDidTap
        case signInButtonDidTap
    }
    enum Mutation {}
    struct State {}
    
    var initialState: State
    // MARK: - Init
    init() {
        initialState =  State(
            
        )
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInButtonDidTap:
            return .empty()
        case .signUpButtonDidTap:
            steps.accept(DaverStep.signUpIsRequired)
            return .empty()
        }
    }
}
