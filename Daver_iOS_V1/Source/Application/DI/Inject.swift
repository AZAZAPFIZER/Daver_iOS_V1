//
//  Inject.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import Swinject

@propertyWrapper
final class Inject<T>{
    let wrappedValue: T
    init(){
        wrappedValue = AppDelegate.container.resolve(T.self)!
    }
}
