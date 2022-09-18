//
//  StepperAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

class StepperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingStepper.self) { _ in
            OnBoardingStepper()
        }
    }
}
