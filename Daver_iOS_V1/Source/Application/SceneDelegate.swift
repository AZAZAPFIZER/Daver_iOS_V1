//
//  SceneDelegate.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let disposeBag: DisposeBag = .init()
    private let coordinator: FlowCoordinator = .init()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let s = (scene as? UIWindowScene) else { return }
        
        coordinateLogger()
        coordinateToAppFlow(with: s)
    }
    
    private func coordinateToAppFlow(with scene: UIWindowScene){
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let appFlow = AppFlow(with: window)
        let appStepper = AppStepper()
        
        coordinator.coordinate(flow: appFlow, with: appStepper)
        window.makeKeyAndVisible()
    }
    
    private func coordinateLogger(){
        coordinator.rx.willNavigate
            .subscribe(onNext: { flow, step in
                let currentFlow = "\(flow)".split(separator: " ").last ?? "No Flow"
                print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
            })
            .disposed(by: disposeBag)
    }
}

