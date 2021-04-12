//
//  MiddleStepper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import Foundation

import RxFlow
import RxRelay

struct MiddleStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
}
