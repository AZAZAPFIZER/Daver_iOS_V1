//
//  FriendFlow.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/08.
//

import RxFlow
import RxRelay

struct FriendStepper: Stepper {
    let steps: PublishRelay<Step> = .init()

    var initialStep: Step {
        return DaverStep.friendIsRequired
    }
}

final class FriendFlow: Flow {
    // MARK: - Properties

    var root: Presentable {
        return self.rootVC
    }
    @Inject var stepper: FriendStepper
    private let rootVC = UINavigationController()

    // MARK: - Init
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }

    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asDaverStep else { return .none }
        switch step {
        case .friendIsRequired:
            return navigateToFriend()
        case .requestFriendIsRequired:
            return navigateToReqFriend()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension FriendFlow {
    func navigateToReqFriend() -> FlowContributors {
        @Inject var reactor: ReqFriendReactor
        let vc = ReqFriendVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    func navigateToFriend() -> FlowContributors {
        @Inject var reactor: FriendReactor
        let vc = FriendVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}

