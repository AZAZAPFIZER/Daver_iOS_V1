//
//  HomeFlow.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import RxFlow
import RxRelay

struct HomeStepper: Stepper {
    let steps: PublishRelay<Step> = .init()

    var initialStep: Step {
        return DaverStep.homeIsRequired
    }
}

final class HomeFlow: Flow {
    // MARK: - Properties

    var root: Presentable {
        return self.rootVC
    }
    @Inject var stepper: HomeStepper
    private let rootVC = UINavigationController()

    // MARK: - Init
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }

    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asDaverStep else { return .none }
        switch step {
        case .homeIsRequired:
            return navigateToHome()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension HomeFlow {
    func navigateToHome() -> FlowContributors {
        @Inject var reactor: HomeReactor
        let vc = HomeVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
