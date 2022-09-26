//
//  OnBoarginReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import ReactorKit
import RxRelay
import RxFlow

final class SignInReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action {
        case signUpButtonDidTap
        case forgotPwButtonDidTap
        case pwVisibleButtonDidTap
        case updateId(String)
        case updatePw(String)
    }
    enum Mutation {
        case setPwVisible(Bool)
        case setId(String)
        case setPw(String)
    }
    struct State {
        var pwVisible: Bool
        var valid: Bool
        var id: String
        var pw: String
    }
    
    var initialState: State
    // MARK: - Init
    init() {
        initialState =  State(
            pwVisible: true,
            valid: false,
            id: "",
            pw: ""
        )
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signUpButtonDidTap:
            steps.accept(DaverStep.signUpIsRequired)
            return .empty()
        case .forgotPwButtonDidTap:
            steps.accept(DaverStep.forgotPwIsRequired)
            return .empty()
        case .pwVisibleButtonDidTap:
            return .just(.setPwVisible(!currentState.pwVisible))
        case let .updateId(id):
            return .just(.setId(id))
        case let .updatePw(pw):
            return .just(.setPw(pw))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPwVisible(pwVisible):
            newState.pwVisible = pwVisible
        case let .setId(id):
            newState.id = id
        case let .setPw(pw):
            newState.pw = pw
        }
        newState.valid = checkValidation(newState)
        return newState
    }
    
}

private extension SignInReactor {
    func checkValidation(_ state: State) -> Bool {
        guard !state.id.isEmpty,
              !state.pw.isEmpty else { return false}
        return true
    }
}
