//
//  ProfileFlow.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import RxFlow
import RxRelay

struct ProfileStepper: Stepper {
    let steps: PublishRelay<Step> = .init()

    var initialStep: Step {
        return DaverStep.profileIsRequired
    }
}

final class ProfileFlow: Flow {
    // MARK: - Properties

    var root: Presentable {
        return self.rootVC
    }
    @Inject var stepper: ProfileStepper
    private let rootVC = UINavigationController()

    // MARK: - Init
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }

    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asDaverStep else { return .none }
        switch step {
        case .rootIsRequired:
            return navigateToRoot()
            
        case let .reProfileIsRequired(info):
            return navigateToreProfilfe(info)
            
        case .profileIsRequired:
            return navigateToProfile()
            
        case .myPageSettingIsRequired:
            return navigateToEditProfile()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension ProfileFlow {
    private func navigateToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
    
    private func navigateToreProfilfe(_ info: Info) -> FlowContributors {
        let vc = DependencyProvider.share.container.resolve(ProfileVC.self, argument: info)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    
    private func navigateToProfile() -> FlowContributors {
        let vc = DependencyProvider.share.container.resolve(ProfileVC.self, argument: Info())!
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    
    private func navigateToEditProfile() -> FlowContributors {
        @Inject var reactor: EditProfileReactor
        let vc = EditProfileVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
