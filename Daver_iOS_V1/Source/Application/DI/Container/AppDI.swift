//
//  AppDI.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import Swinject
import SwinjectAutoregistration

extension Container{
    func registerDependencies() {
        registerVC()
        registerReactor()
        registerStepper()
        registerFlow()
        registerRepositories()
        registerUseCases()
    }
    // MARK: - View
    private func registerVC(){}
    private func registerReactor(){}
    private func registerStepper(){}
    private func registerFlow(){}
    // MARK: - Data
    private func registerRepositories(){}
    private func registerUseCases(){}
}
