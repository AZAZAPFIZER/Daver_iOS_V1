//
//  AuthRepository.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Foundation
import RxSwift

protocol AuthRepository {
    func signUp(_ request: SignUpRequest) -> Single<Void>
    func signIn(_ request: SignInRequest) -> Single<Void>
}
