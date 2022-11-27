//
//  ReqFriendReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/27.
//

import RxRelay
import ReactorKit
import RxFlow

final class ReqFriendReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    
    // MARK: - Reactor
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    init() {
        initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
    }
}
