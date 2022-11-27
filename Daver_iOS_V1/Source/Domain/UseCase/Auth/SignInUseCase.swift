//
//  SignInUseCase.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/17.
//

import RxSwift

class SignInUseCase: ParamUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func buildUseCaseObservable(_ param: Param) -> Single<Void> {
        return authRepository.signIn(param.signInRequest)
    }
    
    class Param {
        let signInRequest: SignInRequest
        
        init(signInRequest: SignInRequest) {
            self.signInRequest = signInRequest
        }
    }
}
