//
//  AuthUseCase.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import RxSwift

class SignUpUseCase: ParamUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func buildUseCaseObservable(_ param: Param) -> Single<Void> {
        return authRepository.signUp(param.signUpRequest)
    }

    class Param {
        let signUpRequest: SignUpRequest

        init(signUpRequest: SignUpRequest) {
            self.signUpRequest = signUpRequest
        }
    }
}

