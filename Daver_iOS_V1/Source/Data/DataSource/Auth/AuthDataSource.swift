//
//  AuthDataSource.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Moya
import RxSwift

class AuthDataSource: baseDataSource<AuthRemote, Any?> {
    func signUp(_ request: SignUpRequest) -> Single<Void> {
        remote.postSignUp(request)
    }
    
    func signIn(_ request: SignInRequest) -> Single<Response<SignInResponse>> {
        remote.postSignIn(request)
    }
}
