//
//  DaverError.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

enum DaverError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
}
