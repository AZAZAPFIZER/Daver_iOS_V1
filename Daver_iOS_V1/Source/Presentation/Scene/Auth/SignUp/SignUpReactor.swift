//
//  SignUpReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/18.
//

import ReactorKit
import RxRelay
import RxFlow

final class SignUpReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State = State()
    
    // MARK: - Reactor
    enum Action {}
    
    struct Mutation {}
    
    struct State {}
}
