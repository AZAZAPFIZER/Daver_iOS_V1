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
    private let signInUseCase: SignInUseCase
    private let signInRquest = SignInRequest()
    
    // MARK: - Reactor
    enum Action {
        case signUpButtonDidTap
        case signInButtonDidTap
        case forgotPwButtonDidTap
        case pwVisibleButtonDidTap
        case updateId(String)
        case updatePw(String)
    }
    enum Mutation {
        case setPwVisible(Bool)
        case setId(String)
        case setPw(String)
        
        case setSuccessLogin(Bool)
        case setLoading(Bool)
        case setError(Error)
    }
    struct State {
        var pwVisible: Bool
        var valid: Bool
        var id: String
        var pw: String
        
        var isSuccessLogin: Bool
        var isLoading: Bool
        var errorMessage: String?
    }
    
    var initialState: State
    // MARK: - Init
    init(
        signInUseCase: SignInUseCase
    ) {
        self.signInUseCase = signInUseCase
        initialState =  State(
            pwVisible: false,
            valid: false,
            id: "",
            pw: "",
            isSuccessLogin: false,
            isLoading: false,
            errorMessage: ""
        )
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signUpButtonDidTap:
            steps.accept(DaverStep.signUpIsRequired)
            return .empty()
            
        case .signInButtonDidTap:
            steps.accept(DaverStep.mainTabbarIsRequired)
            return .empty()
//            return signInButtonDidTap()
            
        case .forgotPwButtonDidTap:
            steps.accept(DaverStep.forgotPwIsRequired)
            return .empty()
            
        case .pwVisibleButtonDidTap:
            return .just(.setPwVisible(!currentState.pwVisible))
            
        case let .updateId(id):
            signInRquest.id = id
            return .just(.setId(id))
            
        case let .updatePw(pw):
            signInRquest.pw = pw.sha512()
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
            
        case let .setSuccessLogin(isSuccessLogin):
            if isSuccessLogin {
                steps.accept(DaverStep.mainTabbarIsRequired)
            }
            newState.isSuccessLogin = isSuccessLogin
        case let .setLoading(loading):
            newState.isLoading = loading
        case let.setError(error):
            if let error = error as? DaverError,
               case let .error(message, _) = error {
                newState.errorMessage = message
            } else {
                newState.errorMessage = "알수없는 오류가 발생했습니다."
            }
            newState.isLoading = false
            newState.isSuccessLogin = false
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
    
    func signInButtonDidTap() -> Observable<Mutation> {
        let start = Observable.just(Mutation.setLoading(true))
        let req = signInUseCase.buildUseCaseObservable(SignInUseCase.Param(signInRequest: signInRquest))
            .asObservable()
            .map { _ in Mutation.setSuccessLogin(true) }
        let end = Observable.just(Mutation.setLoading(false))
        
        return .concat([start, req, end])
            .catch {
                .just(Mutation.setError($0))
            }
    }
}
