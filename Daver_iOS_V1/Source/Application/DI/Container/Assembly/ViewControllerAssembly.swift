//
//  ViewControllerAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingVC.self) { r in
            OnBoardingVC(reactor: r.resolve(OnBoardingReactor.self))
        }
    }
}
