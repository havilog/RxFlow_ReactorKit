//
//  ServiceProvider.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

protocol ServiceProviderType {
    var userService: UserServiceType { get set }
    
}

struct ServiceProvider: ServiceProviderType {
    var userService: UserServiceType = UserService()
}
