//
//  DependencyProvider.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/17.
//

import Swinject

class DependencyProvider {
    static let share = DependencyProvider()
    
    let container = Container()
    let assembler: Assembler
    
    init() {
        Container.loggingFunction = nil
        assembler = Assembler(
            [
                RepositoryAssembly(),
                ReactorAssembly(),
                DataSourceAssembly(),
                UseCaseAssembly(),
                ViewControllerAssembly(),
                StepperAssembly(),
                FlowAssembly()
            ],
            container: container
        )
    }
}
