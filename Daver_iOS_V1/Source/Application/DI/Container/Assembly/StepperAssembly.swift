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
        
        // MARK: - MainTabbar
        container.register(HomeStepper.self) { _ in
            HomeStepper()
        }
        container.register(ProfileStepper.self) { _ in
            ProfileStepper()
        }
        container.register(FriendStepper.self) { _ in
            FriendStepper()
        }
    }
}
