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
        
        // MARK: - Main
        container.register(MainTabbarFlow.self) { _ in
            MainTabbarFlow()
        }
        
        // MARK: - Items
        container.register(HomeFlow.self) { _ in
            HomeFlow()
        }
        container.register(ProfileFlow.self) { _ in
            ProfileFlow()
        }
        container.register(FriendFlow.self) { _ in
            FriendFlow()
        }
    }
}
