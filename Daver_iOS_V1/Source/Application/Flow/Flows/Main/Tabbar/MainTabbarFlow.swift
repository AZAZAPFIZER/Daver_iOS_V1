//
//  MainTabbarFlow.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import RxFlow

final class MainTabbarFlow: Flow {
    // MARK: - Properties
    enum TabIndex: Int {
        case home = 0
        case profile
    }
    var root: Presentable {
        return self.rootVC
    }
    private let rootVC = MainTabbarVC()
    
    @Inject private var homeFlow: HomeFlow
    @Inject private var profileFlow: ProfileFlow
    @Inject private var friendFlow: FriendFlow
    
    // MARK: - Init
    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asDaverStep else { return .none }
        switch step {
        case .mainTabbarIsRequired:
            return navigateToMainTabbar()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainTabbarFlow {
    private func navigateToMainTabbar() -> FlowContributors {
        Flows.use(
            homeFlow
            , profileFlow
            , friendFlow
            , when: .created
        ) { [unowned self] (homeRoot: UINavigationController
                            , profileRoot: UINavigationController
                            , friendRoot: UINavigationController) in
            // Image
            let homeImage = UIImage(systemName: "house")?.tintColor(.systemGray4)
            let friendImage = UIImage(systemName: "person.line.dotted.person")?.tintColor(.systemGray4)
            let profileImgae = UIImage(systemName: "person.crop.circle")?.tintColor(.systemGray4)

            // SelectedImage
            let homeSelectedImage = UIImage(systemName: "house.fill")?.tintColor(UIColor(named: "Daver_Primary_Purple")!)
            let friendSelectedImage = UIImage(systemName: "person.line.dotted.person.fill")?.tintColor(UIColor(named: "Daver_Primary_Purple")!)
            let profileSelectedImage = UIImage(systemName: "person.crop.circle.fill")?.tintColor(UIColor(named: "Daver_Primary_Purple")!)

            // Item
            let homeItem = UITabBarItem(title: "홈", image: homeImage, selectedImage: homeSelectedImage)
            let friendItem = UITabBarItem(title: "친구", image: friendImage, selectedImage: friendSelectedImage)
            let profileItem = UITabBarItem(title: "프로필", image: profileImgae, selectedImage: profileSelectedImage)
            
            let selectedColor   = UIColor(named: "Daver_Primary_Purple")!
            let unselectedColor = UIColor(named: "Daver_Gray")!
            
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
            
            homeRoot.tabBarItem = homeItem
            friendRoot.tabBarItem = friendItem
            profileRoot.tabBarItem = profileItem

            self.rootVC.setViewControllers([homeRoot, friendRoot, profileRoot], animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: friendFlow, withNextStepper: friendFlow.stepper),
            .contribute(withNextPresentable: profileFlow, withNextStepper: profileFlow.stepper)
        ])
    }
}
