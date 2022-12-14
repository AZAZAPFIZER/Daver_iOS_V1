//
//  OnBoardingFlow.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import RxFlow
import RxRelay
import Then
import ReactorKit
import UIKit

struct OnBoardingStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return DaverStep.signInIsRequired
    }
}

final class OnBoardingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: SignInVC
    @Inject var stepper: OnBoardingStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asDaverStep else { return .none }
        switch step {
        case .signInIsRequired:
            return navigateToOnBoardingVC()
        case .signUpIsRequired:
            return navigateTosignUpVC()
        case .rootIsRequired:
            return navigateToRoot()
        case .forgotPwIsRequired:
            return .none
        case .mainTabbarIsRequired:
            return .end(forwardToParentFlowWithStep: DaverStep.mainTabbarIsRequired)
        default:
            return .none
        }
    }
}
private extension OnBoardingFlow {
    private func navigateToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
    
    private func navigateToOnBoardingVC() -> FlowContributors {
        @Inject var signInUseCase: SignInUseCase
        let reator = SignInReactor(signInUseCase: signInUseCase)
        let vc = SignInVC(reactor: reator)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reator))
    }
    
    private func navigateTosignUpVC() -> FlowContributors {
        @Inject var signUpUseCase: SignUpUseCase
        let reactor = SignUpReactor(signUpUseCase: signUpUseCase)
        let vc = SignUpVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
