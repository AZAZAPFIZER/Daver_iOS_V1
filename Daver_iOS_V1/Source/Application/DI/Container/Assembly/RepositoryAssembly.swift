//
//  RepositoryAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthRepository.self) { r in
            AuthRepositoryImpl(authDataSource: r.resolve(AuthDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register(PeopleRepository.self) { r in
            PeopleRepositoryImpl(peopleDataSource: r.resolve(PeopleInfoDataSource.self)!)
        }.inObjectScope(.container)
    }
}
