//
//  SignUpReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/18.
//

import ReactorKit
import RxRelay
import RxFlow

final class SignUpReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    private let signUpUseCase: SignUpUseCase
    private let signUpRequest = DependencyProvider.share.container.resolve(SignUpRequest.self)!
    
    // MARK: - Reactor
    enum Action {
        case signUpButtonDidTap
        case updateName(String)
        case updateId(String)
        case updatePw(String)
        case pwVisibleButtonDidTap
        case updatePwCheck(String)
        case pwCheckVisibleButtonDidTap
        case updateAddress(String)
        case signInButtonDidTap
    }
    
    enum Mutation {
        case setName(String)
        case setId(String)
        case setPw(String)
        case setPwVisible(Bool)
        case setPwCheck(String)
        case setPwCheckVisible(Bool)
        case setAddress(String)
        case setSuccessSignUp(Bool)
        case setLoading(Bool)
    }
    
    struct State {
        var name: String
        var id: String
        var pw: String
        var pwVisible: Bool
        var pwCheck: String
        var pwCheckVisible: Bool
        var address: String
        var valid: Bool
        var isSuccessSignUp: Bool
        var isLoading: Bool
    }
    
    init(
        signUpUseCase: SignUpUseCase
    ) {
        self.signUpUseCase = signUpUseCase
        initialState = State(
            name: "",
            id: "",
            pw: "",
            pwVisible: false,
            pwCheck: "",
            pwCheckVisible: false,
            address: "",
            valid: false,
            isSuccessSignUp: false,
            isLoading: false
        )
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signUpButtonDidTap:
            return signUpButtonDidTap()
            
        case let .updateName(name):
            signUpRequest.name = name
            return .just(.setName(name))
            
        case let .updateId(id):
            signUpRequest.id = id
            return .just(.setId(id))
            
        case let .updatePw(pw):
            signUpRequest.pw = pw
            return .just(.setPw(pw))
            
        case let .updatePwCheck(pwCheck):
            return .just(.setPwCheck(pwCheck))
            
        case let .updateAddress(address):
            signUpRequest.address = address
            return .just(.setAddress(address))
            
        case .pwVisibleButtonDidTap:
            return .just(.setPwVisible(!currentState.pwVisible))
            
        case .pwCheckVisibleButtonDidTap:
            return .just(.setPwCheckVisible(!currentState.pwCheckVisible))
            
        case .signInButtonDidTap:
            steps.accept(DaverStep.rootIsRequired)
            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setName(name):
            newState.name = name
            
        case let .setId(id):
            newState.id = id
            
        case let .setPw(pw):
            newState.pw = pw
            
        case let .setPwCheck(pwCheck):
            newState.pwCheck = pwCheck
            
        case let .setAddress(address):
            newState.address = address
            
        case let .setPwVisible(pwVisible):
            newState.pwVisible = pwVisible
            
        case let .setPwCheckVisible(pwCheckVisible):
            newState.pwCheckVisible = pwCheckVisible
            
        case let .setSuccessSignUp(bool):
            newState.isSuccessSignUp = bool
            
        case let .setLoading(loading):
            newState.isLoading = loading
        }
        
        newState.valid = checkValidation(newState)
        return newState
    }
    
}

extension SignUpReactor {
    private func signUpButtonDidTap() -> Observable<Mutation> {
        steps.accept(DaverStep.rootIsRequired)
        let start = Observable.just(Mutation.setLoading(true))
        let req = signUpUseCase.buildUseCaseObservable(SignUpUseCase.Param(signUpRequest: signUpRequest))
            .asObservable()
            .map { _ in Mutation.setSuccessSignUp(true) }
        let end = Observable.just(Mutation.setLoading(false))
        return .concat([start, req, end])
    }
    
    func checkValidation(_ state: State) -> Bool {
        guard !state.id.isEmpty,
              !state.pw.isEmpty,
              !state.name.isEmpty,
              !state.pwCheck.isEmpty,
              !state.address.isEmpty,
              checkPasswordCheckValidation(pw: state.pw, pwCheck: state.pwCheck)
        else { return false}
        return true
    }
    
    func checkPasswordCheckValidation(pw: String, pwCheck: String) -> Bool {
        return pw == pwCheck
    }
}
