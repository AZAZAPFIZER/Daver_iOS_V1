//
//  PeopleInfoRemote.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

import Foundation
import RxSwift

class PeopleInfoRemote: baseRemote<PeopleInfoAPI>{
    func getPeopleInfo() -> Single<[People]> {
        return self.request(.getPeopleInfo)
            .map ({ res in
                print(String(data: res.data, encoding: .utf8))
                return res
            })
            .map(Response<PeopleData>.self)
            .map { $0.data.memberInfo }
    }
}
