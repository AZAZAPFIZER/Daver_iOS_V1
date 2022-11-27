//
//  PeopleDataSource.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

import Foundation
import RxSwift

class PeopleInfoDataSource: baseDataSource<PeopleInfoRemote, Any?> {
    func fetchPeopleInfo() -> Single<[People]> {
        return remote.getPeopleInfo()
    }
}
