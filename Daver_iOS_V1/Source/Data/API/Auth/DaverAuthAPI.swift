//
//  DaverAuthAPI.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Moya

enum DaverAuthAPI {
    case postSignUp(_ request: SignUpRequest)
    case postSignIn(_ request: SignInRequest)
}

extension DaverAuthAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .postSignUp:
            return URL(string: Constants.DEFAULT_HOST + "member")!
            
        case .postSignIn:
            return URL(string: Constants.DEFAULT_HOST + "member")!
        }
    }
    
    var path: String {
        switch self {
        case .postSignUp:
            return "/join"
            
        case .postSignIn:
            return "/login"
        }
    }
    
    var method: Method {
        switch self {
        case .postSignUp:
            return .post
            
        case .postSignIn:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .postSignUp(request):
            return .requestData(try! JSONEncoder().encode(request))
            
        case let.postSignIn(request):
            return .requestData(try! JSONEncoder().encode(request))
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
