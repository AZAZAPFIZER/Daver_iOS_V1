//
//  ReactorAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignInReactor.self) { _ in
            SignInReactor()
        }
        
        container.register(SignUpReactor.self) { r in
            SignUpReactor(signUpUseCase: r.resolve(SignUpUseCase.self)!)
        }
    }
}
