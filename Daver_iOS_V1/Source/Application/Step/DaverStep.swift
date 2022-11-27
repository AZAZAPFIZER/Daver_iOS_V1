//
//  DaverStep.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import RxFlow

enum DaverStep: Step {
    // MARK: - Etc
    case rootIsRequired
    
    // MARK: - OnBoardingFlow
    case signInIsRequired
    case signUpIsRequired
    case forgotPwIsRequired
    
    // MARK: - MainFlow
    case mainTabbarIsRequired
    case homeIsRequired
    case profileIsRequired
    case friendIsRequired
    
    // MARK: - Profile
    case myPageSettingIsRequired
    
    // MARK: - Friend
    case requestFriendIsRequired
    case reProfileIsRequired(Info)
}
