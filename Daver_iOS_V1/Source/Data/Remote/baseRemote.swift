//
//  baseRemote.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Moya
import RxSwift
import Alamofire
import AVFoundation

class baseRemote<T: TargetType> {
    lazy var request = TokenRefreshRequest(refreshToken: AuthController.getInstance().getRefreshToken())
    lazy var authProvider = MoyaProvider<DaverTokenAPI>(plugins: [NetworkLoggerPlugin()])
    let provider = MoyaProvider<T>(plugins: [NetworkLoggerPlugin()])
    let decoder = JSONDecoder()

    func request(_ token: MoyaProvider<T>.Target, callbackQueue: DispatchQueue? = nil) -> Single<Moya.Response> {
        return Observable<Moya.Response>.create { [weak self] subscriber in
            guard let self else { return Disposables.create() }
            self.provider.request(token) { result in
                switch result {
                case let .success(res):
                    subscriber.onNext(res)
                case let .failure(e):
                    subscriber.onError(e)
                }
            }
            return Disposables.create()
        }.asSingle()
    }
    private func tokenRefresh(token: MoyaProvider<T>.Target) -> Single<Moya.Response> {
        return Observable<Moya.Response>.create { [weak self] subscriber in
            guard let self else { return Disposables.create() }
            self.provider.request(token) { result in
                switch result {
                case let .success(res):
                    subscriber.onNext(res)
                case let .failure(e):
                    subscriber.onError(e)
                }
            }
            return Disposables.create()
        }.asSingle()
            .map(Response<String>.self, using: decoder)
            .flatMap { [weak self] response -> Single<Moya.Response> in
                guard let self = self else { return .error(DaverError.error(message: "네트워크 오류가 발생했습니다.", errorBody: ["error": "baseRemote:35"])) }
                AuthController.getInstance().tokenRefresh(token: response.data)
                return self.provider.rx.request(token)
            }.catchError { error in
                if let error = error as? DaverError,
                   case let .error(_, body) = error,
                   let status = body["status"] as? Int,
                   status == 410 {
                    return .error(DaverError.error(message: "세션이 만료되었습니다."))
                }
                return .error(error)
            }
    }
}
