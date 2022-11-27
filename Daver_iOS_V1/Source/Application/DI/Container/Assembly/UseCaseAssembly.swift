//
//  UseCaseAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignUpUseCase.self) { r in
            SignUpUseCase(authRepository: r.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(SignInUseCase.self) { r in
            SignInUseCase(authRepository: r.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(FetchPeopleLocationUseCase.self) { r in
            FetchPeopleLocationUseCase(peopleRepository: r.resolve(PeopleRepository.self)!)
        }.inObjectScope(.container)
    }
}
