//
//  AuthRepositoryImpl.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import RxSwift
import Moya
import Alamofire
import CryptoSwift
import RxCocoa

class AuthRepositoryImpl: AuthRepository {
    private let authDataSource: AuthDataSource
    
    init(authDataSource: AuthDataSource) {
        self.authDataSource = authDataSource
    }
    
    func signUp(_ request: SignUpRequest) -> Single<Void> {
        authDataSource.signUp(request)
    }
    
    func signIn(_ request: SignInRequest) -> Single<Void> {
        return authDataSource.signIn(request)
            .flatMap { response -> Single<Void> in
                AuthController.getInstance().signIn(token: response.data.accessToken!, refreshToken: response.data.refreshToken!)
                return .just(Void())
            }
    }
}
