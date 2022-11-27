//
//  baseUseCase.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/01.
//

protocol baseUseCase {
    associatedtype T
    func buildUseCaseObservable() -> T
}
