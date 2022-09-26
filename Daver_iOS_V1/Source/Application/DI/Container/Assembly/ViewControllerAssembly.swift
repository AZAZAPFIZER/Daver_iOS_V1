//
//  ViewControllerAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignInVC.self) { r in
            SignInVC(reactor: r.resolve(SignInReactor.self))
        }
        
        container.register(SignUpVC.self) { r in
            SignUpVC(reactor: r.resolve(SignUpReactor.self))
        }
    }
}
