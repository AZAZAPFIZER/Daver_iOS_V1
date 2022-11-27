//
//  baseDataSource.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Moya

class baseDataSource <RM, CH> {
    let remote: RM
    let cache: CH

    init(remote: RM, cache: CH) {
        self.remote = remote
        self.cache = cache
    }
}
