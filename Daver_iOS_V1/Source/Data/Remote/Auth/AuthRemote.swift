//
//  AuthRemote.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import RxSwift

class AuthRemote: baseRemote<DaverAuthAPI> {
    func postSignUp(_ request: SignUpRequest) -> Single<Void> {
        self.request(.postSignUp(request))
            .map { _ in Void() }
    }
    func postSignIn(_ request: SignInRequest) -> Single<Response<SignInResponse>> {
        self.request(.postSignIn(request))
            .map({ res in
                print(res)
                return res
            })
            .map(Response<SignInResponse>.self, using: decoder)
    }
}
