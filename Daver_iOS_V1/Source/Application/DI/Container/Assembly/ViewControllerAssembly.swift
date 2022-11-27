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
        
        // MARK: - Main VC
        container.register(HomeVC.self) { r in
            HomeVC(reactor: r.resolve(HomeReactor.self))
        }
        container.register(ProfileVC.self) { r, info in
            ProfileVC(reactor: r.resolve(ProfileReactor.self), info: info)
        }
        container.register(FriendVC.self) { r in
            FriendVC(reactor: r.resolve(FriendReactor.self))
        }
        
        // MARK: - Profile
        container.register(EditProfileVC.self) { r in
            EditProfileVC(reactor: r.resolve(EditProfileReactor.self))
        }
        
        // MARK: - Friend
        container.register(ReqFriendVC.self) { r in
            ReqFriendVC(reactor: r.resolve(ReqFriendReactor.self))
        }
        
    }
}
