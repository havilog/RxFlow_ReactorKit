//
//  ServiceProvider.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

protocol ServiceProviderType: class {
    var userService: UserServiceType { get set }
    var loginService: LoginServiceType { get set }
    
}

final class ServiceProvider: ServiceProviderType {
    lazy var userService: UserServiceType = UserService(provider: self)
    lazy var loginService: LoginServiceType = LoginService(provider: self)
}
