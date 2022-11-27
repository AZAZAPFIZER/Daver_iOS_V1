//
//  ReactorAssembly.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

final class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignInReactor.self) { r in
            SignInReactor(signInUseCase: r.resolve(SignInUseCase.self)!)
        }
        
        container.register(SignUpReactor.self) { r in
            SignUpReactor(signUpUseCase: r.resolve(SignUpUseCase.self)!)
        }
        
        // MARK: Main Reactor
        container.register(HomeReactor.self) { r in
            HomeReactor(fetchPeopleLocationUseCase: r.resolve(FetchPeopleLocationUseCase.self)!)
        }
        container.register(ProfileReactor.self) { _ in
            ProfileReactor()
        }
        container.register(FriendReactor.self) { _ in
            FriendReactor()
        }
        
        // MARK: - Profile
        container.register(EditProfileReactor.self) { _ in
            EditProfileReactor()
        }
        
        // MARK: - Friend
        container.register(ReqFriendReactor.self) { _ in
            ReqFriendReactor()
        }
    }
}
