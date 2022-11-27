//
//  PeopleRepositoryImpl.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

import Foundation
import RxSwift

class PeopleRepositoryImpl: PeopleRepository {
    private let peopleDataSource: PeopleInfoDataSource
    
    init(peopleDataSource: PeopleInfoDataSource) {
        self.peopleDataSource = peopleDataSource
    }
    
    func fetchPeopleInfo() -> Single<[People]> {
        return peopleDataSource.fetchPeopleInfo()
    }
    
}
