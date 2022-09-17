//
//  StepExt.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import RxFlow

extension Step{
    var asDaverStep: DaverStep? {
        return self as? DaverStep
    }
}
