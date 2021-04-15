//
//  Step+asSample.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import RxFlow

extension Step {
    var asSampleStep: SampleStep? {
        return self as? SampleStep
    }
}
