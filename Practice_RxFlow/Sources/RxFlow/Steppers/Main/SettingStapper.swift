//
//  SettingStapper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import Foundation

import RxFlow
import RxRelay

struct SettingStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
}
