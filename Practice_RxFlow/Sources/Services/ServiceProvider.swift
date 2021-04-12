//
//  ServiceProvider.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

protocol ServiceProviderType: class {
    var networkService: NetworkManagerType { get }
    var loginService: LoginServiceType { get }
    
}

final class ServiceProvider: ServiceProviderType {
    lazy var networkService: NetworkManagerType = NetworkManager()
    lazy var loginService: LoginServiceType = LoginService(provider: self)
}
