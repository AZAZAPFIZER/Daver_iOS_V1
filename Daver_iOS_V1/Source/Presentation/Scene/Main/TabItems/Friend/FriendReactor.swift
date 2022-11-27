//
//  FriendReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/08.
//

import ReactorKit
import RxFlow
import RxRelay

final class FriendReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    
    // MARK: - Reactor
    enum Action {
        case onAppear
        case modifyButtonDidTap
    }
    
    enum Mutation {
        case setFriends([FriendList])
    }
    
    struct State {
        var friendList: [FriendList]
    }
    
    init() {
        initialState = State(
            friendList: []
        )
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .onAppear:
            return onAppear()
            
        case .modifyButtonDidTap:
            steps.accept(DaverStep.requestFriendIsRequired)
            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setFriends(list):
            list.forEach { friend in
                
//                newState.friendList = friend
            }
            newState.friendList = list
        }
        
        return newState
    }
    
}

extension FriendReactor {
    private func onAppear() -> Observable<Mutation> {
        return .concat([
            .just(.setFriends([.dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy]))
        ])
    }
}
