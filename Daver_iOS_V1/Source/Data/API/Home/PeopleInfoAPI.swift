//
//  PeopleInfoAPI.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

import Moya

enum PeopleInfoAPI {
    case getPeopleInfo
}

extension PeopleInfoAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getPeopleInfo:
            return URL(string: Constants.DEFAULT_HOST + "member")!
        }
    }
    
    var path: String {
        switch self {
        case .getPeopleInfo:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .getPeopleInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPeopleInfo:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        headers["Authorization"] = Constants.ACCESS_TOKEN
        return headers
    }
}
