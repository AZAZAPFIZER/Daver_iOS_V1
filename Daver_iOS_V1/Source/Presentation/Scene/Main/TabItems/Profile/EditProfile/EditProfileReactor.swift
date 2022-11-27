//
//  EditProfileReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/27.
//

import RxRelay
import ReactorKit
import RxFlow

class Info {
    var name: String = "김상은"
    var intro: String =
"""
        안녕하세요 저는 대구에 살고있는 고등학생 김상은입니당
        저의 취미는 축구이고, iOS 개발을 공부하고 있어요 ~ ㅎㅎ
        혹시 심심하시다면 저랑 친구해요!!
"""
}

final class EditProfileReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    
    private var info = Info()
    
    // MARK: - Reactor
    enum Action {
        case done
        case name(String)
        case intro(String)
    }
    
    enum Mutation {
        case setName(String)
        case setIntro(String)
    }
    
    struct State {
        var name: String = ""
        var intro: String = ""
    }
    
    init() {
        initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .done:
            steps.accept(DaverStep.reProfileIsRequired(info))
            return .empty()
            
        case let .name(name):
            info.name = name
            return .just(.setName(name))
            
        case let .intro(intro):
            info.intro = intro
            return .just(.setIntro(intro))
        }
        
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setName(name):
            newState.name = name
            
        case let .setIntro(intro):
            newState.intro = intro
        }
        
        return newState
    }
}
