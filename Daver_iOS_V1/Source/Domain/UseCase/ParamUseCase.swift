//
//  ParamUseCase.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

protocol ParamUseCase {
    associatedtype T
    associatedtype P
    func buildUseCaseObservable(_ param: P) -> T
}
