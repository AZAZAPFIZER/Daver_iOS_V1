//
//  DataSourceAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class DataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthDataSource.self) { _ in
            AuthDataSource(remote: AuthRemote(), cache: nil)
        }.inObjectScope(.container)
        
        container.register(SignUpRequest.self) { _ in
            SignUpRequest()
        }.inObjectScope(.container)
    }
}
