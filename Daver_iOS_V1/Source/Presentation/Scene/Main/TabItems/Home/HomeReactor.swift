//
//  HomeReactor.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import ReactorKit
import RxRelay
import RxFlow

final class HomeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    var initialState: State
    
    let fetchPeopleLocationUseCase: FetchPeopleLocationUseCase
    
    // MARK: - Reactor
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setLocationLoading(Bool)
        case setPeoplesLocation([People])

        case setError(Error)
    }
    
    struct State {
        var isLocationLoading: Bool
        var members: [People]
        
        var errorMessage: String?
    }
    
    init(
        fetchPeopleLocationUseCase: FetchPeopleLocationUseCase
    ) {
        self.fetchPeopleLocationUseCase = fetchPeopleLocationUseCase
        
        initialState = State(
            isLocationLoading: false,
            members: [People()],
            errorMessage: nil
        )
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return getPeopleInfo()
//            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setError(error):
            if let error = error as? DaverError,
               case let .error(message, _) = error {
                newState.errorMessage = message
            } else {
                newState.errorMessage = "알수없는 오류가 발생했습니다."
            }
            
        case let .setLocationLoading(isLoading):
            newState.isLocationLoading = isLoading
            
        case let .setPeoplesLocation(member):
            newState.members = member
        }
        
        return newState
    }
}

extension HomeReactor {
    private func getPeopleInfo() -> Observable<Mutation> {
        let str = Observable.just(Mutation.setLocationLoading(true))
        let req = fetchPeopleLocationUseCase.buildUseCaseObservable()
            .asObservable()
            .map { Mutation.setPeoplesLocation($0)}
        let end = Observable.just(Mutation.setLocationLoading(true))
        return Observable.concat([str, req, end]).catch { .just(Mutation.setError($0)) }
    }
}
