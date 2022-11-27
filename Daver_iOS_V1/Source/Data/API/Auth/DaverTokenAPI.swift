//
//  DaverTokenAPI.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Moya

enum DaverTokenAPI {
    case tokenRefresh(_ request: TokenRefreshRequest)
}

extension DaverTokenAPI: TargetType {
    // EndPoint
    var baseURL: URL {
        return URL(string: Constants.DEFAULT_HOST+"token")!
    }

    // 서버의 도메인 뒤에 추가 될 Path (일반적으로 API)
    var path: String {
        switch self {
            case .tokenRefresh:
                return ""
        }
    }

    // HTTP method (GET, POST, …)
    var method: Method {
        switch self {
            case .tokenRefresh:
                return .post
        }
    }

    // 테스트용 Mock Data
    var sampleData: Data {
        return Data()
    }

    // 리퀘스트에 사용되는 파라미터 설정
    var task: Task {
        switch self {
            case let .tokenRefresh(request):
                return .requestData(try! JSONEncoder().encode(request))
        }
    }

    // 허용할 response의 타입
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }

    // HTTP header
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        return headers
    }

}
