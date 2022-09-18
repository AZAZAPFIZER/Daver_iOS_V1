//
//  FlowAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

class FlowAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingFlow.self) { _ in
            OnBoardingFlow()
        }
    }
}
