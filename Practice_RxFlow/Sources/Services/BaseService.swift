//
//  BaseService.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
