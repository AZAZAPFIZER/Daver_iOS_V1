//
//  FetchPeopleLocationUseCase.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

import RxSwift

class FetchPeopleLocationUseCase: baseUseCase {
    private let peopleRepository: PeopleRepository
    
    init(peopleRepository: PeopleRepository) {
        self.peopleRepository = peopleRepository
    }
    
    func buildUseCaseObservable() -> Single<[People]> {
        return peopleRepository.fetchPeopleInfo()
    }
}
