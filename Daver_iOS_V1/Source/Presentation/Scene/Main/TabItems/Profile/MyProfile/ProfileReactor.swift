//
//  ProfileReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import ReactorKit
import RxRelay
import RxFlow

final class ProfileReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    
    // MARK: - Reactor
    enum Action {
        case modifyButtonDidTap
    }
    
    enum Mutation {}
    
    struct State {}
    
    init() {
        initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .modifyButtonDidTap:
            steps.accept(DaverStep.myPageSettingIsRequired)
            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {}
    
}
