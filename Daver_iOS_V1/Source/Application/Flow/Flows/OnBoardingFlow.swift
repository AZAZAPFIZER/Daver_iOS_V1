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
        return DaverStep.onBoardingIsRequired
    }
}

final class OnBoardingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var vc: OnBoardingVC
    @Inject var stepper: OnBoardingStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        switch step {
            case
        }
    }
}
